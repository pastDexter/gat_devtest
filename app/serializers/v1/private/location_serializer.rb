class V1::Private::LocationSerializer < ActiveModel::Serializer
  include ExternalId

  attributes :name, :secret_code, :location_groups

  def location_groups
    object.location_groups.as_json(only: [:name])
  end

end