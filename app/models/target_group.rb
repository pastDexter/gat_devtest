class TargetGroup < ApplicationRecord
  include TreeTraversable

  belongs_to :panel_provider, optional: true
  belongs_to :parent, class_name: 'TargetGroup', optional: true
  has_many :children, class_name: 'TargetGroup', foreign_key: 'parent_id'
  has_and_belongs_to_many :countries

  validates :name, :external_id, :secret_code, presence: true

end
