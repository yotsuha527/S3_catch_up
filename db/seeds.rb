# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(
    email: "test1@test.com",
    name: "テスト1",
    password: "asdasd"
    )
user.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/monster01.png')),
filename: 'monster01.png')

user = User.create!(
    email: "test2@test.com",
    name: "テスト2",
    password: "asdasd"
)
user.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/monster02.png')),
filename: 'monster02.png')

user = User.create!(
    email: "test3@test.com",
    name: "テスト3",
    password: "asdasd"
)
user.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/monster03.png')),
filename: 'monster03.png')

user = User.create!(
    email: "test4@test.com",
    name: "テスト4",
    password: "asdasd"
)
user.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/monster04.png')),
filename: 'monster04.png')

user = User.create!(
    email: "test5@test.com",
    name: "テスト5",
    password: "asdasd"
)
user.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/monster05.png')),
filename: 'monster05.png')

user = User.create!(
    email: "test6@test.com",
    name: "テスト6",
    password: "asdasd"
)
user.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/monster06.png')),
filename: 'monster06.png')

User.all.each do |user|
    user.books.create!(
      title: "タイトル#{user.id}",
      body: "テキストテキストテキストテキスト"
    )
end

User.all.each do |user|
    user.books.create!(
      title: "あ#{user.id}",
      body: "ん#{user.id}"
    )
end