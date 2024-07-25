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
  user.name = "ジュン"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/user-profile2.png"), filename:"user-profile2.png")
end

megumi = User.find_or_create_by!(email: "megumi@example.com") do |user|
  user.name = "めぐみ"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/dog4.png"), filename:"dog4.png")
end

dog = Category.find_or_create_by!(name: "犬")

cat = Category.find_or_create_by!(name: "猫")

rabbit = Category.find_or_create_by!(name: "うさぎ")

hamster = Category.find_or_create_by!(name: "ハムスター")

pochi = james.animals.find_or_create_by!(name: "ポチ") do |animal|
  animal.sex = :male
  animal.age = "12歳"
  animal.character = "活発"
  animal.category = dog
  animal.animal_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/dog2.jpg"), filename:"dog2.jpg")
end

tama = james.animals.find_or_create_by!(name: "タマ") do |animal|
  animal.sex = :female
  animal.age = "2歳"
  animal.character = "さみしがりや"
  animal.category = cat
end

kuro = emma.animals.find_or_create_by!(name: "クロ") do |animal|
  animal.sex = :male
  animal.age = "5歳"
  animal.character = "甘えん坊"
  animal.category = cat
end

yuki = jun.animals.find_or_create_by!(name: "ゆき") do |animal|
  animal.sex = :female
  animal.age = "0歳6ヶ月"
  animal.character = "おとなしい"
  animal.category = rabbit
  animal.animal_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/rabbit.jpg"), filename:"rabbit.jpg")
end

ribon = jun.animals.find_or_create_by!(name: "リボン") do |animal|
  animal.sex = :female
  animal.age = "1歳"
  animal.character = "好奇心旺盛"
  animal.category = hamster
  animal.animal_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/hamster.jpg"), filename:"hamster.jpg")
end

fang = megumi.animals.find_or_create_by!(name: "ファング") do |animal|
  animal.sex = :male
  animal.age = "5歳"
  animal.character = "おりこうさん"
  animal.category = dog
  animal.animal_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/dog4.png"), filename:"dog4.png")
end

james.posts.find_or_create_by!(caption: "うちのわんこ") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/dog.jpg"), filename:"dog.jpg")
  post.animal_posts.new(animal: pochi)
end

james.posts.find_or_create_by!(caption: "うちのにゃんこ") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/cat.jpg"), filename:"cat.jpg")
  post.animal_posts.new(animal: tama)
end

emma.posts.find_or_create_by!(caption: "黒猫") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/cat2.png"), filename:"cat2.png")
  post.animal_posts.new(animal: kuro)
end

jun.posts.find_or_create_by!(caption: "イースター！") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/rabbit2.jpg"), filename:"rabbit2.jpg")
  post.animal_posts.new(animal: yuki)
end

jun.posts.find_or_create_by!(caption: "食事中です") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/hamster.jpg"), filename:"hamster.jpg")
  post.animal_posts.new(animal: ribon)
end

megumi.posts.find_or_create_by!(caption: "かわいい！") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/dog3.jpg"), filename:"dog3.jpg")
  post.animal_posts.new(animal: fang)
end

megumi.posts.find_or_create_by!(caption: "かっこいい！") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/app/assets/images/dog5.png"), filename:"dog5.png")
  post.animal_posts.new(animal: fang)
end

puts "dataの作成に成功しました"
