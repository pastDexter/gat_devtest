FactoryBot.define do
  factory :access_token do
    key { SecureRandom.uuid }
    expiration_date { 3.days.from_now }
  end
end