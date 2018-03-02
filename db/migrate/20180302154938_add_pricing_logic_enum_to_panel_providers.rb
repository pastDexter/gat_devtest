class AddPricingLogicEnumToPanelProviders < ActiveRecord::Migration[5.1]
  def change
    add_column :panel_providers, :pricing_logic, :integer, default: 1, null: false
  end
end
