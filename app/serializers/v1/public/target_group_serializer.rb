class V1::Public::TargetGroupSerializer < ActiveModel::Serializer
  include ExternalId

  attributes :name, :parent_id

  def parent_id
    scope[:id_to_external][object.parent_id]
  end

end