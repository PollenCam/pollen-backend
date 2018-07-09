FactoryBot.define do
  factory :membership do
    role 'attendee'
    user
    event
  end
end
