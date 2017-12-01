require 'rails_helper'

describe Review do
  describe 'validations' do
    context 'rating' do
      let(:review_without_rating) { build :review, rating: nil }
      let(:review_with_invalid_rating) { build :review, rating: 6 }

      it 'validates the rating' do
        expect(review_without_rating).to_not be_valid
        expect(review_with_invalid_rating).to_not be_valid
      end
    end
  end

  describe '.created_at_desc' do
    let!(:first_review) { create :review }
    let!(:second_review) { create :review }
    let!(:third_review) { create :review }

    it 'orders descending by create date' do
      expect(Review.created_at_desc).to eq([third_review, second_review, first_review])
    end
  end
end
