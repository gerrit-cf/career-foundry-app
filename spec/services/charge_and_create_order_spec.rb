require 'rails_helper'

describe ChargeAndCreateOrder do
  let(:user) { create :user }
  let(:product) { create :product }
  let(:service) { described_class.new(**params) }
  let(:params) do
    {
      user: user,
      product: product,
      token: '1234567890'
    }
  end
  let(:charge_mock) { double(paid?: true) }

  subject { service.process }

  before do
    allow(Stripe::Charge).to receive(:create).and_return(charge_mock)
  end

  it { is_expected.to be_successful }

  it 'creates an order' do
    expect { subject }.to change(Order, :count).by(1)
    expect(Order.last.product).to eq(product)
    expect(Order.last.total).to eq(product.price)
  end

  it 'triggers a payment' do
    subject
    expect(Stripe::Charge).to have_received(:create).with({
      amount: product.price_in_cents,
      currency: 'eur',
      description: product.description,
      source: params[:token]
    })
  end

  context 'with a failing payment' do
    let(:charge_mock) { double(paid?: false) }

    it { is_expected.to_not be_successful }

    it 'does not create an order' do
      expect { subject }.to_not change(Order, :count)
    end

    it 'contains the correct errors' do
      expect(subject.errors.collect(&:name)).to eq([:not_billed])
    end
  end

  context 'with a declined credit card' do
    let(:stripe_card_error) { Stripe::CardError.new(:foo, :bar, :baz) }

    before do
      allow(Stripe::Charge).to receive(:create).and_raise(stripe_card_error)
    end

    it { is_expected.to_not be_successful }

    it 'does not create an order' do
      expect { subject }.to_not change(Order, :count)
    end

    it 'contains the correct errors' do
      expect(subject.errors.collect(&:name)).to eq([:card_declined])
    end
  end
end
