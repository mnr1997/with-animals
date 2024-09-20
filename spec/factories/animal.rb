FactoryBot.define do
  factory :animal do
    name { Faker::Lorem.characters(number: 5) }
    age { Faker::Lorem.characters(number: 2) }
    character { Faker::Lorem.characters(number: 6) }
    us
    
    after(:build) do |animal|
      user.profile_image.attach(io: File.open('spec/images/no_image.jpg'), filename: 'no_image.jpg', content_type: 'application/xlsx')
    end
  end
end