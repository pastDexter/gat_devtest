class Country < ApplicationRecord

  belongs_to :panel_provider
  has_many :location_groups

  validates :country_code, format: {
    with: /\A[A-Z]{2}\z/,
    message: 'only allows two capital letters codes'
  }

end
