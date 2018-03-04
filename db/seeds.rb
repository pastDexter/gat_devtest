LETTERS = ('A'..'Z').to_a

##################
# PanelProviders
##################

panel_providers = PanelProvider.create([
  { code: 'panel-provider-code-1', pricing_logic: :time_a },
  { code: 'panel-provider-code-2', pricing_logic: :lotr_arrays },
  { code: 'panel-provider-code-3', pricing_logic: :time_nodes }
])

##################
# Countries
##################

countries = Country.create([
  { country_code: 'PL', panel_provider: panel_providers[0] },
  { country_code: 'US', panel_provider: panel_providers[1] },
  { country_code: 'AU', panel_provider: panel_providers[2] }
])

##################
# LocationGroups
##################

location_groups = LocationGroup.create([
  { name: 'Group A', country: countries[0], panel_provider: panel_providers[0] },
  { name: 'Group B', country: countries[1], panel_provider: panel_providers[1] },
  { name: 'Group C', country: countries[2], panel_provider: panel_providers[2] },
  { name: 'Group D', country: countries[0] }
])

##################
# Locations
##################

locations_args = Array.new(20) do |i|
  l = LETTERS[i]
  { name: "City #{l}", external_id: "c#{l}", secret_code: "secret#{l}",  }
end
Location.create(locations_args)

##################
# TargetGroups
##################

root_target_groups = TargetGroup.create([
  { name: 'Target A', external_id: 'tA', secret_code: 'secretA', panel_provider: panel_providers[0], countries: [countries[0], countries[1]] },
  { name: 'Target B', external_id: 'tB', secret_code: 'secretB', panel_provider: panel_providers[1], countries: [countries[0], countries[2]] },
  { name: 'Target C', external_id: 'tC', secret_code: 'secretC', panel_provider: panel_providers[2], countries: [countries[1], countries[2]] },
  { name: 'Target D', external_id: 'tD', secret_code: 'secretD', countries: [countries[2]] }
])

def generate_children_groups(roots, count, deep)
  return if deep <= 0
  roots.each do |r|
    args = Array.new(count) do |i|
      l = LETTERS[i]
      { name: r.name + l, external_id: r.external_id + l, secret_code: r.secret_code + l, parent: r }
    end
    generate_children_groups(TargetGroup.create(args), count, deep - 1)
  end
end

generate_children_groups(root_target_groups, 2, 3)
