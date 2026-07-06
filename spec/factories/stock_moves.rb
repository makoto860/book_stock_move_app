FactoryBot.define do
  factory :stock_move do
    association :book
    association :from_location, factory: [ :location, :warehouse ]
    association :to_location, factory: [ :location, :pick ]
    quantity { 1 }
    move_type { "移動の型" }
  end
end
