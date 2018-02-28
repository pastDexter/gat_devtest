FactoryBot.define do
  factory :location do
    sequence(:name) { |n| "Location #{n}" }
    sequence(:external_id) { |n| "loc_#{n}" }
    secret_code 'secret123'
  end
end