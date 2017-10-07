class User < ApplicationRecord
  has_one :subscription
  accepts_nested_attributes_for :subscription
  has_many :favorite_screens
  has_many :favorites, -> { distinct }, through: :favorite_screens, source: :screen
  has_many :downloaded_screens
  has_many :downloaded, -> { distinct }, through: :downloaded_screens, source: :screen

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  has_many :user_permissions, dependent: :destroy
  has_many :permissions, through: :user_permissions

  after_touch :clear_association_cache

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable

  # validate :accept_terms_and_conditions

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end

  def subscribed?
    subscription.present? && subscription.stripe_subscription_id?
  end

  def accept_terms_and_conditions
    unless terms_and_conditions?
      errors.add(:terms_and_conditions, "must be accepted")
    end
  end
end
