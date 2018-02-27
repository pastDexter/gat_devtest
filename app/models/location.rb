class Location < ApplicationRecord

  has_and_belongs_to_many :location_groups

  validates :name, :external_id, :secret_code, presence: true

end
