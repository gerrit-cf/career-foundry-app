class ProductsController < ApplicationController
  before_action :authenticate!, except: %i[index show]
  before_action :load_product, only: %i[show edit update destroy]

  def index
    @search_term = params[:search_term]
    @products = if @search_term
                  Product.name_like(@search_term)
                else
                  Product.all
                end
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(permitted_params)

    if @product.save
      flash[:success] = 'Product was created.'
      redirect_to product_path(@product)
    else
      flash.now[:error] = 'The product could not be created. Please check your inputs.'
      render :new
    end
  end

  def update
    @product.assign_attributes(permitted_params)

    if @product.save
      flash[:success] = 'Product was updated.'
      redirect_to product_path(@product)
    else
      flash.now[:error] = 'The product could not be updated. Please check your inputs.'
      render :edit
    end
  end

  def destroy
    @product.destroy!
    flash[:success] = "Product '#{@product.name}' deleted."
    redirect_to products_path
  end

  private

  def permitted_params
    params.require(:product).permit(:name, :description, :image_url, :colour, :price)
  end

  def load_product
    @product = Product.find(params[:id])
  end
end
