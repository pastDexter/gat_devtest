class V1::Public::TargetGroupSerializer < ActiveModel::Serializer

  attributes :name, :external_id, :parent_external_id

  def parent_external_id
    scope[:id_to_external][object.parent_id]
  end

end