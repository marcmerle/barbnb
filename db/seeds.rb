# frozen_string_literal: true

##
# User DB Seed
20.times do
  User.create!(
    email: Faker::Internet.email,
    password: "coucou"
  )
end

##
# Bar DB Seed
User.all.sample(10).each do |user|
  Bar.create!(
    owner: user,
    name: Faker::Restaurant.name,
    address: Faker::Address.full_address,
    price: rand(25..100),
    description: Faker::Restaurant.description,
    capacity: rand(10..150),
    opening_start: rand(9..20),
    opening_end: rand(21..23)
  )
end

def random_date
  Time.zone.at(0.0 + rand * (Time.now.to_f - 0.0))
end

##
# Bookings DB Seed
User.all.sample(15).each do |user|
  bar = Bar.all.sample
  number = rand(2..bar.capacity)
  amount = number * bar.price
  date = [random_date, random_date]

  Booking.create!(
    bar: bar,
    user: user,
    guest_number: number,
    amount: amount,
    starts_at: date.min,
    ends_at: date.max,
    state: "Ongoing"
  )
end
