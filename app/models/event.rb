require 'securerandom'

class Event < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  validates :locator, uniqueness: true

  def initialize(*)
    super
    assign_locator
  end

  def assign_locator
    loop do
      self.locator = generate_locator
      break self.locator unless Event.find_by(locator: self.locator)
    end
  end

  def owner
    memberships.find_by(role: :owner).user
  end

  private

  def generate_locator
    SecureRandom.uuid.rpartition('-').last
  end
end
