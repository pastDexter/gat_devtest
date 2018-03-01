FactoryBot.define do
  factory :target_group do
    sequence(:name) { |n| "Target Group #{n}" }
    sequence(:external_id) { |n| "tg_#{n}" }
    secret_code 'secret123'
  end
end