User.create!(name: "従業員専用_管理者",
  email: "admin-employee@email.com",
  password: "password",
  admin: true)

  Customer.create!(name: "お客様_管理者",
    email: "admin-customer@email.com",
    password: "password",
    admin: true)

5.times do |n|
  name  = Faker::Name.name
  email = "staff-#{n+1}@email.com"
  password = "password"
  employee_number = (n+1)+100
  User.create!(name: name,
      email: email,
      password: password,
      employee_number: employee_number)
end

20.times do |n|
  name  = Faker::Name.name
  email = "customer-#{n+1}@email.com"
  password = "password"
  customer_number = (n+1)+200
  Customer.create!(name: name,
      email: email,
      password: password,
      customer_number: customer_number)
end