FactoryBot.define do
  factory :user do
    sequence(:full_name) { |n| "User #{n}" }
    email
    password 'password'
    sequence(:auth_token) { |n| sprintf('%08d', n) }
  end
end
