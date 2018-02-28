FactoryBot.define do
  factory :panel_provider do
    sequence(:code) { |n| "pp#{n}" }
  end
end