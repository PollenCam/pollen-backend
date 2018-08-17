class Image < ApplicationRecord
  belongs_to :membership
  has_one :user, through: :membership
  has_one :event, through: :membership
end
