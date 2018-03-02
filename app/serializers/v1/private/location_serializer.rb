class V1::Private::LocationSerializer < ActiveModel::Serializer
  include ExternalId

  attributes :name, :secret_code

end