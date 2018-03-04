class LocationGroup < ApplicationRecord

  belongs_to :country
  belongs_to :panel_provider, optional: true
  has_and_belongs_to_many :locations

  validates :name, presence: true

end