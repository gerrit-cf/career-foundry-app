class ProductsController < ApplicationController
  before_action :authenticate!, except: %i[index show]
  before_action :set_product, only: %i[show edit update destroy]

  def index
    authorize Product, :show?
    @search_term = params[:search_term]
    @products = if @search_term
                  Product.name_like(@search_term)
                else
                  Product.all
                end
  end

  def show
    authorize product, :show?

    @reviews = product.reviews.first(5)
    @review = product.reviews.new(review_params)
  end

  def new
    @product = Product.new
    authorize product, :new?
  end

  def edit
    authorize product, :edit?
  end

  def create
    @product = Product.new(permitted_params)
    authorize @product, :create?

    if product.save
      flash[:success] = 'Product was created.'
      redirect_to product_path(product)
    else
      flash.now[:error] = 'The product could not be created. Please check your inputs.'
      render :new
    end
  end

  def update
    product.assign_attributes(permitted_params)
    authorize product, :update?

    if product.save
      flash[:success] = 'Product was updated.'
      redirect_to product_path(product)
    else
      flash.now[:error] = 'The product could not be updated. Please check your inputs.'
      render :edit
    end
  end

  def destroy
    authorize product, :destroy?
    product.destroy!
    flash[:success] = "Product '#{product.name}' deleted."
    redirect_to products_path
  end

  private

  attr_reader :product

  def permitted_params
    params.require(:product).permit(:name, :description, :image_url, :colour, :price)
  end

  def review_params
    return {} unless params[:review]

    params.require(:review).permit(:comment)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
