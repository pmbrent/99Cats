# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |i|
  Cat.create!(name: "Sennacy#{i+1}", color: "black",
              birth_date: Time.parse("01/#{i+1}/2014"),
              description: "Best cat ever", sex: "M")
  CatRentalRequest.create!(cat_id: i+1, start_date: (Date.today - 30 * i),
                           end_date: (Date.today + 5 * i) )

end
