class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :images

  enum role: { attendee: 0, owner: 10 }
end
