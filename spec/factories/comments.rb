FactoryBot.define do
  factory :comment do
    user
    movie
    body "MyText"
  end
end
