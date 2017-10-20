FactoryGirl.define do
  factory :review do
    comment 'Nice bike. I\'d rate 5/7 if I could'
    rating  4

    after(:build) do |review|
      review.user = create(:user) if review.user.blank?
      review.reviewable = create(:product) if review.reviewable.blank?
    end
  end
end
