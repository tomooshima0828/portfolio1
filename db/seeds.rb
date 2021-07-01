
User.create!(name: "管理者",
  email: "admin@email.com",
  password: "password",
  control_number: 101,
  phone: "090-0000-0101",
  address: "神奈川県厚木市愛甲",
  admin: true,
  staff: true)

3.times do |n|
  name  = "担当者#{n+1}"
  email = "staff-#{n+1}@email.com"
  password = "password"
  control_number = (n+1)+200
  address = Faker::Address.full_address
  phone = Faker::PhoneNumber.cell_phone
  User.create!(name: name,
      email: email,
      password: password,
      control_number: control_number,
      address: address,
      phone: phone,
      staff: true)
end

20.times do |n|
  name  = "お客様#{n+1}"
  email = "customer-#{n+1}@email.com"
  password = "password"
  control_number = (n+1)+300
  address = Faker::Address.full_address
  phone = Faker::PhoneNumber.cell_phone
  User.create!(name: name,
      email: email,
      password: password,
      control_number: control_number,
      address: address,
      phone: phone)
end

Menu.create!(
  item: "カット",
  item_number: 1,
  price: 4000
)

Menu.create!(
  item: "シャンプー",
  item_number: 2,
  price: 1000
)

Menu.create!(
  item: "カラー",
  item_number: 3,
  price: 3000
)

Menu.create!(
  item: "パーマ",
  item_number: 4,
  price: 3000
)

Menu.create!(
  item: "着付け",
  item_number: 5,
  price: 5000
)