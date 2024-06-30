# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
end

james.posts.find_or_create_by!(caption: "テスト投稿") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/cat.jpeg"), filename:"sample-post3.jpg")
end

james.animals.find_or_create_by!(name: "ポチ") do |animal|
  animal.sex = 0
  animal.age = "12歳"
  animal.character = "活発"
end

james.animals.find_or_create_by!(name: "タマ") do |animal|
  animal.sex = 1
  animal.age = "2歳"
  animal.character = "さみしがりや"
end

Category.find_or_create_by!(name: "犬") do |category|
end

Category.find_or_create_by!(name: "猫") do |category|
end

puts "dataの作成に成功しました"
