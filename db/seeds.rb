# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w[0.json 1.json 2.json 3.json 4.json].each do |file_name|
  file = File.read("#{Rails.root}/samples/#{file_name}")
  coordinates_hash = JSON.parse(file)

  Trace.create(coordinates: coordinates_hash.to_json)
  puts "Trace created from file #{file_name}"
end
