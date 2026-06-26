FactoryBot.define do
  factory :location do
    sequence(:name) { |n| "ロケーション#{n}" }
    kind { :warehouse }
  end
end
