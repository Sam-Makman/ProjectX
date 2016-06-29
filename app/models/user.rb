class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONENUMBER_REGEX = /\A\d{3}-\d{3}-\d{4}\z/i
  attr_accessor :remember_token
  validates :email, presence: true, length: { maximum: 255 },
          format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :home_phone, format: { with:VALID_PHONENUMBER_REGEX }
  validates :cell_phone, format: { with:VALID_PHONENUMBER_REGEX }
  has_many :caregivers, dependent: :destroy
  has_secure_password
  validates :password, length: { minimum: 6 }

  # Returns the hash digest of the given string.
   def User.digest(string)
     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                   BCrypt::Engine.cost
     BCrypt::Password.create(string, cost: cost)
   end

   # Returns a random token.
   def User.new_token
     SecureRandom.urlsafe_base64
   end

   # Remembers a user in the database for use in persistent sessions.
   def remember
     self.remember_token = User.new_token
     update_attribute(:remember_digest, User.digest(remember_token))
   end

   # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

end
