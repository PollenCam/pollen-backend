FactoryBot.define do
  sequence(:email) { |n| "user_#{n}@example.com" }
end
