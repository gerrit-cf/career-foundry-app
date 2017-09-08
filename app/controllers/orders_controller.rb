class OrdersController < ApplicationController
  before_action :authenticate!
  before_action :set_order, only: %i[show destroy]

  def index
    authorize Order, :index?
  end

  def show
    authorize @order, :show?
  end

  def new
    @order = Order.new
    authorize @order, :new?
  end

  def create
    @order = policy_scope(Order).new(order_params)
    authorize @order
  end

  def destroy
    authorize @order, :destroy?
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :total)
  end

  def set_order
    @order = policy_scope(Order).find(params[:id])
  end
end
