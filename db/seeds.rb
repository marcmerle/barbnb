# frozen_string_literal: true

require 'open-uri'

Geocoder.configure(timeout: 60)

class String
  def green
    "\e[32m#{self}\e[0m"
  end

  def blue
    "\e[34m#{self}\e[0m"
  end
end

bars_file = File.read("db/places.json")
bars_data = JSON.parse(bars_file)
##
# User DB Seed

20.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: "123456"
  )
end
puts "20 users have been seeded with password #{password}.".green

##
# Bar DB Seed

bars_data.first(100).each_with_index do |bar_data, i|
  bar = Bar.new(
    owner: User.all.sample,
    name: bar_data["name"],
    address: bar_data["geoloc_address"],
    price: rand(10..25),
    description: Faker::Restaurant.description,
    capacity: rand(1..20) * 10,
    opening_start: rand(17..20),
    opening_end: rand(21..23)
  )

  bar_data["pictures"].each_with_index do |bar_picture, i|
    url = bar_picture["picture_file"]["url"]
    file = URI.open(url)
    bar.photos.attach(io: file, filename: "bar_#{bar.id}_#{i + 1}.png", content_type: 'image/png')
  end

  bar.save!
  puts "Bar ##{i + 1} was created (#{bar.photos.count} pictures)".blue
end
puts "#{Bar.count} bars were created".green

def random_date
  two_weeks_ago = (Time.zone.now - 15.days).to_f
  two_weeks_from_now = (Time.zone.now + 15.days).to_f
  Time.zone.at(((two_weeks_from_now - two_weeks_ago) * rand + two_weeks_ago)).to_datetime
end

##
# Bookings DB Seed
User.all.sample(300).each do |user|
  bar = Bar.all.sample
  number = rand(2..bar.capacity)
  amount = number * bar.price

  start_hour = rand(bar.opening_start...bar.opening_end)
  starts_at = random_date.change(hour: start_hour)

  end_hour = rand(start_hour + 1..bar.opening_end)
  ends_at = random_date.change(hour: end_hour)
  states = ["Annulé"]
  states.fill("À venir", states.size, 4) # To simulate a 20% cancellation rate

  state = ends_at < Time.zone.now ? "Terminé" : states.sample

  booking = Booking.new(
    bar: bar,
    user: user,
    guest_number: number,
    amount: amount,
    starts_at: starts_at,
    ends_at: ends_at,
    state: state
  )
  booking.cancelled_by = [booking.user.id, booking.bar.owner.id].sample if state == "Annulé"

  booking.save!
end
puts "15 bookings were created (#{Booking.where(state: 'Annulé').count} annulés, #{Booking.where(state: 'À venir').count} à venir, #{Booking.where(state: 'Terminé').count} terminés)".green

Booking.first.user = User.first
Booking.first.bar = Bar.first

comments = [
  { content: "C'était super !", rating: 4 },
  { content: "C'était pas si super !", rating: 3 },
  { content: "C'était super pas bien !", rating: 1 },
  { content: "C'était super je crois !", rating: 5 },
  { content: "C'était super terrible !", rating: 4 },
  { content: "C'était bien mais je suis un hater !", rating: 2 },
  { content: "C'était top !", rating: 4 },
  { content: "C'était ouf, bières incroyables !", rating: 5 },
  { content: "MEILLEURE SOIRÉE DE MA VIE", rating: 5 },
  { content: "C'était trop bien, j'y retourne dès que possible !", rating: 5 },
  { content: "C'était vraiment cool !", rating: 4 },
  { content: "Cool, cool cool cool", rating: 4 }
]

Booking.all.each do |booking|
  rand(5..10) do
    review = Review.new(comments.sample)
    review.booking = booking
    review.save!
  end
end
puts "Reviews added to booking".green
