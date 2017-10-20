require 'rails_helper'

describe Product do
  let(:first_product) { create :product, name: 'Bike' }
  let(:second_product) { create :product, name: 'Speedster' }
  let(:third_product) { create :product, name: 'Eurowing Bike' }

  describe '#name_like' do
    it 'properly finds products by name' do
      expect(described_class.name_like('speed')).to contain_exactly(second_product)
      expect(described_class.name_like('EURO')).to contain_exactly(third_product)
      expect(described_class.name_like('bike')).to contain_exactly(first_product, third_product)
    end
  end
end
