class AccessToken < ApplicationRecord

  belongs_to :panel_provider

  validates :key, presence: true, uniqueness: true

  def expired?
    expiration_date && expiration_date <= Time.now
  end

end
