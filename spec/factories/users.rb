FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "captain.obvious#{n}@gmail.com" }
    first_name            'Captain'
    last_name             'Obvious'
    password              'insecur3'
    password_confirmation 'insecur3'

    trait :admin do
      role 'admin'
    end
  end
end