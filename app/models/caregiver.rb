class Caregiver < ActiveRecord::Base
  VALID_PHONENUMBER_REGEX = /\A[2-9]\d{2}-\d{3}-\d{4}\z/i
  validates :phone_number, format: { with:VALID_PHONENUMBER_REGEX }
  belongs_to :user
end
