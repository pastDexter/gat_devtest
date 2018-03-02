class TargetEvaluationParams
  include ActiveModel::Validations

  attr_accessor :country_code, :target_group_id, :locations

  validates :country_code, :target_group_id, :locations, presence: true
  validate :country_must_exists, :target_group_must_exists

  def initialize(params = {})
    params = permit_params(params)
    @country_code    = params[:country_code]
    @target_group_id = params[:target_group_id]
    @locations       = params[:locations]
  end

  def permit_params(params)
    params.permit(:country_code, :target_group_id, locations: %i[id panel_size])
  end

  private

  def country_must_exists
    unless Country.exists?(country_code: country_code)
      errors.add(:country_code, 'is invalid')
    end
  end

  def target_group_must_exists
    unless TargetGroup.exists?(external_id: target_group_id)
      errors.add(:target_group_id, 'is invalid')
    end
  end

end