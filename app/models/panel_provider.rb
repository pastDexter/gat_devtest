class PanelProvider < ApplicationRecord

  enum pricing_logic: { time_a: 1, time_nodes: 2, lotr_arrays: 3 }

  has_many :countries
  has_many :location_groups
  has_many :access_tokens
  has_many :target_groups, -> { root_nodes }

  validates :code, presence: true, uniqueness: true
  validates :pricing_logic, presence: true

  def pricing_logic_class
    logic_name = pricing_logic.to_s.classify
    PricingLogic.const_get(logic_name)
  end

end