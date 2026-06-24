# spec/factories/locations.rb
FactoryBot.define do
  factory :location do
    kind { :warehouse }

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