# coding: utf-8

User.create!(name: "管理者",
             email: "admin@email.com",
             user_employee_number: "001",
             user_uid: "1001",
             password: "password",
             password_confirmation: "password",
             admin: true)

User.create!(name: "上長A",
             email: "superior1@email.com",
             user_employee_number: "002",
             user_uid: "1002",
             password: "password",
             password_confirmation: "password",
             superior: true)
             
User.create!(name: "上長B",
             email: "superior2@email.com",
             user_employee_number: "003",
             user_uid: "1003",
             password: "password",
             password_confirmation: "password",
             superior: true)
          
User.create!(name: "一般",
             email: "sample@email.com",
             user_employee_number: "004",
             user_uid: "1004",
             password: "password",
             password_confirmation: "password",
             )
             
60.times do |n|
  name = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  user_employee_number = "#{n+1}"
  user_uid = "#{n+1}"
  password = "password"
  User.create!(name: name,
               email: email,
               user_employee_number: user_employee_number,
               user_uid: user_uid,
               password: password,
               password_confirmation: password)
end