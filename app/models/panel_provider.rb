class PanelProvider < ApplicationRecord

  has_many :countries
  has_many :location_groups
  has_many :access_tokens
  has_many :target_groups, -> { root_nodes }

  validates :code, presence: true, uniqueness: true

end