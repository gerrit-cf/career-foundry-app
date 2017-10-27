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

  delegate :description, :price, :price_in_cents, to: :product

  def create_order
    user.orders.create(
      product: product,
      total: price
    )
  end

  def charge
    add_error :not_billed, 'Your payment could not be processed.' unless stripe_charge.paid?
  rescue Stripe::CardError
    add_error :card_declined, 'Your card was declined.'
  end

  def stripe_charge
    Stripe::Charge.create(
      amount: price_in_cents,
      currency: 'eur',
      description: description,
      source: token
    )
  end
end
