class PaymentsController < ApplicationController
  before_action :authenticate!

  def create
    authorize :payment

    if charge.successful?
      flash[:success] = 'Your payment was processed. Thanks for your order.'
    else
      flash[:error] = error_message
    end

    redirect_to product
  end

  private

  def product
    @product ||= Product.find(params[:product_id])
  end

  def charge
    @charge ||= ChargeAndCreateOrder.new(
      user: current_user,
      product: product,
      token: params[:stripeToken]
    ).process
  end

  def error_message
    'Your payment could not be processed. '.tap do |message|
      message << charge.error_messages.join(' ')
    end
  end
end
