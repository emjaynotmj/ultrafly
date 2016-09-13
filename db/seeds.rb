# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

airports = [
  { name: 'Nnamdi Azikwe International Airport, Abuja', state: 'Abuja'},
  { name: 'Akanu Ibiam International Airport, Enugu', state: 'Enugu'},
  { name: 'Alakia Airport, Ibadan', state: 'Ibadan'},
  { name: 'Arakale Airport, Akure', state: 'Akure'},
  { name: 'Mallam Aminu Kano International Airport, Kano', state: 'Kano'},
  { name: 'Murtala Muhammed International Airport, Lagos', state: 'Lagos'},
  { name: 'Port Harcourt International Airport, Port Harcourt', state: 'Port Harcourt'},
  { name: 'Sir Abubakar Tafawa Balewa Airport, Bauchi', state: 'Bauchi'},
  { name: 'Margaret Ekpo International Airport, Calabar', state: 'Calabar'},
  { name: 'Yakubu Gowon Airport, Jos', state: 'Jos'},
  { name: 'Kaduna Airport, Kaduna', state: 'Kaduna'},
  { name: 'Maiduguri International Airport, Borno', state: 'Borno'},
  { name: 'Sadiq Abubakar III International Airport, Sokoto', state: 'Sokoto'},
  { name: 'Yola Airport, Yola', state: 'Yola'}
]

airlines = ['Arik Air', 'Dana Air', 'Andela Air', 'Sosoliso Air', 'Nigerian Airways', 'Aero Contractors', 'Kuvokiland Airlines', 'Emjay Air', 'Bukky Air', 'Comet Aviation', 'Galaxy Skylines', 'Workdey Air', 'K-S Air', 'Arnold Air', 'Edo Airways', 'Night Crawlers', 'TIA Air', 'Peak Flyers']

airports.each do |airport|
    Airport.create(airport)
end

500.times{
  forward_rand = Random.rand(0..30)
  date = Faker::Time.forward(12, :morning)
  flight = Flight.new
  flight.flight_code = "UF" + Faker::Number.between(100, 500).to_s
  flight.airline_name = airlines.sample
  flight.departure_airport_id = Airport.order('RANDOM()').first.id
  flight.arrival_airport_id = Airport.order('RANDOM()').where.not(id: flight.departure_airport_id).first.id
  flight.departure_date = date
  flight.arrival_date = date + forward_rand.hour
  flight.price = Faker::Commerce.price * 1000
  flight.available_seats = Random.rand(10..30)
  flight.save!
}