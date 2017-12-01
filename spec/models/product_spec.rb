require 'rails_helper'

describe Product do
  let(:product) { create :product, name: 'Bike', price: 2499.99 }

  describe 'validations' do
    context 'name' do
      subject { build :product, name: '' }

      it { is_expected.to_not be_valid }
    end

    context 'price' do
      let(:product_without_price) { build :product, price: nil }
      let(:product_with_invalid_price) { build :product, price: -1 }

      it 'validates the price' do
        expect(product_without_price).to_not be_valid
        expect(product_with_invalid_price).to_not be_valid
      end
    end
  end

  describe '#name_like' do
    let(:second_product) { create :product, name: 'Speedster' }
    let(:third_product) { create :product, name: 'Eurowing Bike' }

    it 'properly finds products by name' do
      expect(described_class.name_like('speed')).to contain_exactly(second_product)
      expect(described_class.name_like('EURO')).to contain_exactly(third_product)
      expect(described_class.name_like('bike')).to contain_exactly(product, third_product)
    end
  end

  describe '#price_in_cents' do
    subject { product.price_in_cents }

    it { is_expected.to eq(249999) }
  end

  describe '#to_s' do
    subject { product.to_s }

    it { is_expected.to eq('Bike') }
  end
end
