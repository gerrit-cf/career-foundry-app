require 'rails_helper'

describe Review do
  subject { create :review }

  describe 'validations' do
    context 'with an invalid rating' do
      before do
        subject.rating = 6
      end

      it { is_expected.to_not be_valid }
    end
  end
end
