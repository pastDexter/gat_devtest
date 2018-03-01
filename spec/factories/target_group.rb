FactoryBot.define do
  factory :target_group do
    sequence(:name) { |n| "Target Group #{n}" }
    sequence(:external_id) { |n| "tg_#{n}" }
    secret_code 'secret123'

    trait :with_panel_provider do
      panel_provider
    end
  end
end