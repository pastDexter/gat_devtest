FactoryBot.define do
  factory :panel_provider do
    sequence(:code) { |n| "pp#{n}" }

    trait :with_access_token do
      after(:build) do |panel_provider|
        create(:access_token, panel_provider: panel_provider)
      end
    end
  end
end