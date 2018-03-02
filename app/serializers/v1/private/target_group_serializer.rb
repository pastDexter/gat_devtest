class V1::Private::TargetGroupSerializer < ActiveModel::Serializer
  include ExternalId

  attributes :name, :secret_code, :parent_id

  def parent_id
    scope[:id_to_external][object.parent_id]
  end

end