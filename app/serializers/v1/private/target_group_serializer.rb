class V1::Private::TargetGroupSerializer < ActiveModel::Serializer

  attributes :name, :external_id, :secret_code, :parent_external_id

  def parent_external_id
    scope[:id_to_external][object.parent_id]
  end

end