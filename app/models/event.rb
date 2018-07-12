require 'securerandom'

class Event < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  validates :locator, uniqueness: true

  delegate :can_upload?, :can_download?, to: :policy

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

  def policy
    @policy ||= EventPolicy.new(start_time: created_at || Time.now)
  end

  private

  def generate_locator
    SecureRandom.uuid.rpartition('-').last
  end
end
