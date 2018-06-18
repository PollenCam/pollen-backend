FactoryBot.define do
  factory :event do
    sequence(:locator) { |n| sprintf('%08d', n) }
  end
end
