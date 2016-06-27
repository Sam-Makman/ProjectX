class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONENUMBER_REGEX = /\A[2-9]\d{2}-\d{3}-\d{4}\z/i
  validates :email, presence: true, length: { maximum: 255 },
          format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :home_phone, format: { with:VALID_PHONENUMBER_REGEX }
  validates :cell_phone, format: { with:VALID_PHONENUMBER_REGEX }
  has_many :caregivers, dependent: :destroy
  has_secure_password
  validates :password, length: { minimum: 6 }
end
