FactoryGirl.define do
  factory :review do
    comment 'Nice bike. I\'d rate 5/7 if I could'
    rating  4

    trait :with_user do
      user
    end
  end
end