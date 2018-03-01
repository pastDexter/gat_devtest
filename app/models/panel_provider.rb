class PanelProvider < ApplicationRecord

  has_many :countries
  has_many :location_groups
  has_many :access_tokens

  validates :code, presence: true, uniqueness: true

end