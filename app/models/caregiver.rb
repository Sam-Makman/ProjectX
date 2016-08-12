class Caregiver < ActiveRecord::Base
  VALID_PHONENUMBER_REGEX = /\A\d{10}\z/i
  validates :phone_number, format: { with:VALID_PHONENUMBER_REGEX }
  belongs_to :user
end
