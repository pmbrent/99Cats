# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |i|
  User.create(user_name: "Jonathan#{i+1}", password: "password#{i+1}")

  Cat.create!(name: "Sennacy#{i+1}", color: "black",
              birth_date: Time.parse("01/#{i+1}/2014"),
              description: "Best cat ever", sex: "M", user_id: i+1)
end

5.times do |i|
  CatRentalRequest.create!(cat_id: 5-i, start_date: (Date.today - 30 * i),
                           end_date: (Date.today + 5 * i), user_id: i+1)
end
