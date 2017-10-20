require 'rails_helper'

describe ProductPresenter do
  let(:product) { create :product }

  before do
    create :review, rating: 4, reviewable: product
    create :review, rating: 2, reviewable: product
    create :review, rating: 3, reviewable: product
  end

  describe '#average_rating' do
    subject { described_class.new(product, nil).average_rating.to_f }

    it { is_expected.to eq(3) }
  end
end
