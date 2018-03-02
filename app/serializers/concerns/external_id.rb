module ExternalId

  def self.included(base)
    base.attributes :id
  end

  def id
    object.external_id
  end

end