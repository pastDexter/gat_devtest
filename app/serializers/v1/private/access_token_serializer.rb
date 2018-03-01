class V1::Private::AccessTokenSerializer < ActiveModel::Serializer

  attributes :token, :expiration_date

  def token
    object.key
  end

end