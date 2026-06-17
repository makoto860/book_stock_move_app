FactoryBot.define do
  factory :book do
    title { "本のタイトル" }
    sequence(:rack_number) { |n| "A-#{n}" }
    sequence(:isbn) { |n| "978〜#{n}" }

    trait :invalid_order_timing do
      special_order_date_time { Time.zone.parse("Y-M-D H:M") }
      order_date_time { Time.zone.parse("Y-M-D H:M") }
    end

    trait :valid_order_timing do
      special_order_date_time { Time.zone.parse("Y-M-D H:M") }
      order_date_time { Time.zone.parse("Y-M-D H:M") }
    end
  end
end
