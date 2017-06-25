class User < ApplicationRecord
  has_one :subscription
  accepts_nested_attributes_for :subscription
  has_many :favorite_screens
  has_many :favorites, through: :favorite_screens, source: :screen
  has_many :downloaded_screens
  has_many :downloaded, through: :downloaded_screens, source: :screen

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  has_many :user_permissions, dependent: :destroy
  has_many :permissions, through: :user_permissions

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

#  validate :accept_terms_and_conditions

  def admin?
    #role == 'admin'
    true
  end

  def accept_terms_and_conditions
    unless terms_and_conditions?
      errors.add(:terms_and_conditions, "must be accepted")
    end
  end
end
