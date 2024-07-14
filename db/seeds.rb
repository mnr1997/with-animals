# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |admin|
  admin.password = ENV["ADMIN_PASSWORD"]
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
end

emma = User.find_or_create_by!(email: "emma@example.com") do |user|
  user.name = "Emma"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/user-profile1.png"), filename:"user-profile1.png")
end

jun = User.find_or_create_by!(email: "jun@example.com") do |user|
  user.name = "じゅん"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/user-profile2.png"), filename:"user-profile2.png")
end

Category.find_or_create_by!(name: "犬") do |category|
end

Category.find_or_create_by!(name: "猫") do |category|
end

Category.find_or_create_by!(name: "うさぎ") do |category|
end

james.animals.find_or_create_by!(name: "ポチ") do |animal|
  animal.sex = 0
  animal.age = "12歳"
  animal.character = "活発"
  animal.category_id = 1
end

james.animals.find_or_create_by!(name: "タマ") do |animal|
  animal.sex = 1
  animal.age = "2歳"
  animal.character = "さみしがりや"
  animal.category_id = 2
end

emma.animals.find_or_create_by!(name: "クロ") do |animal|
  animal.sex = 0
  animal.age = "5歳"
  animal.character = "甘えん坊"
  animal.category_id = 2
end

jun.animals.find_or_create_by!(name: "ゆき") do |animal|
  animal.sex = 1
  animal.age = "0歳6ヶ月"
  animal.character = "おとなしい"
  animal.category_id = 3
  animal.animal_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/rabbit.jpg"), filename:"rabbit.jpg")
end

james.posts.find_or_create_by!(caption: "うちのにゃんこ") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/cat.jpg"), filename:"cat.jpg")
  animal = Animal.find(2)
  post.animal_posts.new(animal: animal)
end

emma.posts.find_or_create_by!(caption: "黒猫") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/cat2.png"), filename:"cat2.png")
  animal = Animal.find(3)
  post.animal_posts.new(animal: animal)
end

jun.posts.find_or_create_by!(caption: "イースター！") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/rabbit2.jpg"), filename:"rabbit2.jpg")
  animal = Animal.find(4)
  post.animal_posts.new(animal: animal)
end

puts "dataの作成に成功しました"
