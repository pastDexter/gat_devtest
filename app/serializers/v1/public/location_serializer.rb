class V1::Public::LocationSerializer < ActiveModel::Serializer
  include ExternalId

  attributes :name

end