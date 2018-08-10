FactoryBot.define do
  factory :user do
    name                   "Test User"
    email                  "user@example.com"
    password               "password"
    password_confirmation  "password"
    confirmed_at           Time.now.utc
  end
end
