class PanelProvider < ApplicationRecord

  has_many :countries
  has_many :location_groups

  validates :code, presence: true, uniqueness: true

end