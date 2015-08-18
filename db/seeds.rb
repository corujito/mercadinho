# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.count == 0
  User.create!(username: 'corujito', email: "corujito@example.com", password: 'corujito', password_confirmation: 'corujito')
end

if Client.count == 0
Client.create!(full_name: "Antonio da Costa", phone: "4588-8898", email: "antoniocosta@naoexiste.com.brk", address: "")
Client.create!(full_name: "Edson Ramos", phone: "", email: "edson@naoexiste.com.brk", address: "")
Client.create!(full_name: "Fabiana Salve", phone: "", email: "", address: "")
Client.create!(full_name: "João da Vila", phone: "1234-1234", email: "", address: "")
Client.create!(full_name: "Marcos Cunha", phone: "", email: "marcoscunha@naoexiste.com.brk", address: "")
Client.create!(full_name: "Ricardo Silva", phone: "16338413234", email: "", address: "")
Client.create!(full_name: "Silvia da Ponte", phone: "", email: "", address: "")
Client.create!(full_name: "Vitor Judas", phone: "", email: "vitorjudas@naoexiste.com.brk", address: "")
end

if Vendor.count == 0
  Vendor.create!(full_name: "Russi Ponte", phone: "4588-8898", email: "russi@naoexiste.com.brk", address: "")
  Vendor.create!(full_name: "Extra", phone: "4588-8898", email: "extra@naoexiste.com.brk", address: "")
  Vendor.create!(full_name: "Boa", phone: "4588-8898", email: "boa@naoexiste.com.brk", address: "")
  Vendor.create!(full_name: "Copercica", phone: "4588-8898", email: "copercica@naoexiste.com.brk", address: "")
end

if Product.count == 0
  Product.create!(full_name: "Cerveja Itaipava", unity: 0)
  Product.create!(full_name: "Cerveja Original", unity: 0)
  Product.create!(full_name: "Coca Cola", unity: 0)
  Product.create!(full_name: "Açucar União", unity: 2)
  Product.create!(full_name: "Óleo de soja", unity: 0)
  Product.create!(full_name: "Picanha", unity: 2)
end

if Card.count == 0
  Card.create!(full_name: "Antonio da Costa", identification: "1123-123-23-23-133", password: "123", cpf: "", phone: "4588-8898", email: "antoniocosta@naoexiste.com.brk")
  Card.create!(full_name: "Edson Ramos", identification: "23132112312", password: "123", cpf: "", phone: "", email: "edson@naoexiste.com.brk")
  Card.create!(full_name: "Fabiana Salve", identification: "", password: "123", cpf: "", phone: "", email: "")
  Card.create!(full_name: "João da Vila", identification: "7777", password: "123", cpf: "", phone: "1234-1234", email: "")
  Card.create!(full_name: "Marcos Cunha", identification: "33.2321 1231", password: "123", cpf: "", phone: "", email: "marcoscunha@naoexiste.com.brk")
end