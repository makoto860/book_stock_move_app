FactoryBot.define do
  factory :location do
    sequence(:name) { |n| "ロケーション#{n}" }

    trait :warehouse do
      kind { :warehouse }
    end

    trait :pick do
      kind { :pick }
    end

    trait :customer do
      kind { :customer }
    end
  end
end