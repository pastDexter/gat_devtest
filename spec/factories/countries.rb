FactoryBot.define do
  factory :country do
    sequence(:country_code) { |i| %w[PL GB US AF AL AD BA BW VG CL][i % 10] }
    panel_provider
  end
end