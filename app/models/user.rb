class User < ApplicationRecord
  devise *%i{
    database_authenticatable
    registerable
    recoverable
    rememberable
    trackable
    validatable

    lockable
    timeoutable
  }

  has_many :memberships
  has_many :events, through: :memberships

  validates :auth_token, uniqueness: true

  def initialize(*)
    super # initialize defines the attr_accessors, so do this before assigning anything
    assign_auth_token
  end

  def assign_auth_token
    self.auth_token = generate_auth_token
  end

  private

  def generate_auth_token
    loop do
      token = Devise.friendly_token
      break token unless User.find_by(auth_token: token)
    end
  end
end
