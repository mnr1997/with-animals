FactoryBot.define do
  factory :animal do
    name { Faker::Lorem.characters(number: 5) }
    user
  end
end