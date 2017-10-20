FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "Bike #{n}" }

    description 'The best bike ever'
    colour      'Red'
    price       1799.99
  end
end