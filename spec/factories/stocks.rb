FactoryBot.define do
  factory :stock do
    quantity { 10 }

    association :book
    association :location
  end
end
