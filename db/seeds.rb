
User.create!(name: "管理者",
  email: "admin@email.com",
  password: "password",
  control_number: 101,
  admin: true,
  staff: true)

3.times do |n|
  name  = "スタッフ#{n+1}"
  email = "staff-#{n+1}@email.com"
  password = "password"
  control_number = (n+1)+200
  User.create!(name: name,
      email: email,
      password: password,
      control_number: control_number,
      staff: true)
end

20.times do |n|
  name  = "お客様#{n+1}"
  email = "customer-#{n+1}@email.com"
  password = "password"
  control_number = (n+1)+300
  User.create!(name: name,
      email: email,
      password: password,
      control_number: control_number)
end