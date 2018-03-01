class Location < ApplicationRecord

  has_and_belongs_to_many :location_groups

  validates :name, :external_id, :secret_code, presence: true

  def self.for_panel_provider(panel_provider)
    joins(location_groups: :panel_provider).where(location_groups: { panel_provider: panel_provider })
  end

  def self.for_country(country)
    joins(location_groups: :country).where(location_groups: { country: country })
  end

end
