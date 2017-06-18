class User < ApplicationRecord
  has_one :subscription
  has_many :favorite_screens
  has_many :favorites, through: :favorite_screens, source: :screen
  has_many :downloaded_screens
  has_many :downloaded, through: :downloaded_screens, source: :screen

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  has_many :user_permissions, dependent: :destroy
  has_many :permissions, through: :user_permissions

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 },
                       confirmation: true, on: :create
  validates_presence_of :password_confirmation, on: :create
#  validate :accept_terms_and_conditions

  def admin?
    #role == 'admin'
    true
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def accept_terms_and_conditions
    unless terms_and_conditions?
      errors.add(:terms_and_conditions, "must be accepted")
    end
  end
end
