class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum role: { attendee: 0, owner: 10 }
end
