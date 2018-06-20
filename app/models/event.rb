require 'securerandom'

class Event < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_many :memberships
  has_many :users, through: :memberships

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

  private

  def generate_locator
    SecureRandom.uuid.rpartition('-').last
  end
end
