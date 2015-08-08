# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
