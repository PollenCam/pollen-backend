class User < ApplicationRecord
  devise *%i{
    database_authenticatable
    registerable
    recoverable
    rememberable
    trackable
    validatable
    confirmable
    lockable
    timeoutable
  }

  validates :auth_token, uniqueness: true
end
