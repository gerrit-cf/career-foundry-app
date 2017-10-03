class ReviewsController < ApplicationController
  PERMITTED_REVIEWABLE_KLASS_NAMES = %w[product].freeze

  def index
    authorize Review, :index?

    @reviews = reviewable.reviews.paginate(page: params[:page])

    render 'reviews/index'
  end

  def create
    review = reviewable.reviews.build(
      review_params.merge(user: current_user)
    )

    authorize review, :create?
    
    if review.save
      flash[:success] = 'Successfully created your comment. Thanks for your feedback.'
      redirect_to polymorphic_path(reviewable)
    else
      flash[:error] = 'Error creating review. Please choose a rating.'
      redirect_to polymorphic_path(reviewable, review: review_params)
    end
  end

  def destroy
    review = policy_scope(Review).find(params[:id])

    authorize review, :destroy?

    review.destroy!

    flash[:success] = 'Review was deleted.'
    redirect_to polymorphic_path(reviewable)
  end
  
  private

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
end
