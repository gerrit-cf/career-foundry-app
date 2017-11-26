class ReviewsController < ApplicationController
  PERMITTED_REVIEWABLE_KLASS_NAMES = %w[product].freeze

  before_action :authenticate!, except: :index

  def index
    authorize Review, :index?

    @reviews = reviewable
                 .reviews
                 .created_at_desc
                 .paginate(page: params[:page])

    push_reviews_to_gon

    render 'reviews/index'
  end

  def create
    @review = reviewable.reviews.build(
      review_params.merge(user: current_user)
    )

    authorize @review, :create?

    respond_to do |format|
      if @review.save
        ProductChannel.broadcast_to reviewable.id, review: @review

        format.html { handle_create_success }
      else
        format.html { handle_create_error }
      end
    end
  end

  def destroy
    review = policy_scope(Review).find(params[:id])

    authorize review, :destroy?
    review.destroy!

    respond_to do |format|
      format.html do
        flash[:success] = 'Der Kommentar wurde gelöscht.'
        redirect_to polymorphic_path(reviewable), status: :see_other
      end

      format.json do
        render json: {
          average_rating: reviewable.average_rating,
          reviews: serialized_reviews(reviewable.teaser_reviews)
        }
      end
    end
  end

  private

  def handle_create_success
    flash[:success] = 'Successfully created your comment. Thanks for your feedback.'
    redirect_to polymorphic_path(reviewable)
  end

  def handle_create_error
    flash[:error] = 'Error creating review. Please choose a rating.'
    redirect_to polymorphic_path(reviewable, review: review_params)
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end

  def reviewable_klass
    @reviewable_klass ||= begin
      raise 'Unpermitted reviewable class' unless reviewable_name_valid?
      reviewable_name.classify.constantize
    end
  end

  def reviewable_name
    @reviewable_name ||= reviewable_params_key.chomp('_id')
  end

  def reviewable_params_key
    params.keys.find { |key, _| key.ends_with?('_id')}.tap do |reviewable_key|
      raise 'No reviewable given' unless reviewable_key.present?
    end
  end

  def reviewable_name_valid?
    reviewable_name.in?(PERMITTED_REVIEWABLE_KLASS_NAMES)
  end

  def reviewable
    @reviewable ||= policy_scope(reviewable_klass).find(params[reviewable_params_key])
  end

  def push_reviews_to_gon
    gon.reviewable_id = reviewable.id
    gon.average_rating = reviewable.average_rating
    gon.reviews = serialized_reviews(@reviews)
  end

  def serialized_reviews(reviews)
    ReviewSerializer.serialize(reviews, is_collection: true)
  end
end
