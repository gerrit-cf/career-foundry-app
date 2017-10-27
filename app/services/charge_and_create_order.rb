class ChargeAndCreateOrder
  include Service::Base

  def initialize(user:, product:, token:)
    @user = user
    @product = product
    @token = token
  end

  def process
    transaction do
      create_order
      charge
    end

    result
  end

  private

  attr_reader :user, :product, :token

  delegate :description, :price, to: :product

  def create_order
    user.orders.create(
      product: product,
      total: price
    )
  end

  def charge
    Stripe::Charge.create(
      amount: total,
      currency: 'eur',
      description: description,
      source: token
    )
  rescue Stripe::CardError
    add_error :card_error, 'Your card was declined.'
  end

  def total
    (price * 100).floor
  end
end
