class V1::Public::LocationSerializer < ActiveModel::Serializer
  include ExternalId

  attributes :name, :location_groups

  def location_groups
    object.location_groups.as_json(only: [:name])
  end

end