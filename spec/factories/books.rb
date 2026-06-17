FactoryBot.define do
  factory :book do
    title { "本のタイトル" }

    sequence(:rack_number) { |n| "A-#{n}" }
    sequence(:isbn) { |n| "978〜#{n}" }
  end
end
