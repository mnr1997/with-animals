FactoryBot.define do
  factory :post do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/images/no_image.jpg"))}
    caption { Faker::Lorem.characters(number: 20) }
    user
  end
end