# frozen_string_literal: true

require 'open-uri'

class String
  def green
    "\e[32m#{self}\e[0m"
  end

  def blue
    "\e[34m#{self}\e[0m"
  end
end

BAR_PICTURES = [
  'https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80',
  'https://images.unsplash.com/photo-1543007630-9710e4a00a20?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80',
  'https://images.unsplash.com/photo-1509807995916-c332365e2d9e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2771&q=80',
  'https://images.unsplash.com/photo-1470337458703-46ad1756a187?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1498&q=80',
  'https://images.unsplash.com/photo-1525268323446-0505b6fe7778?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80',
  'https://images.unsplash.com/photo-1536626064922-49e65368b27d?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',
  'https://images.unsplash.com/photo-1539639885136-56332d18071d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80',
  'https://images.unsplash.com/photo-1491333078588-55b6733c7de6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80',
  'https://images.unsplash.com/photo-1437418747212-8d9709afab22?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=666&q=80',
  'https://images.unsplash.com/photo-1500217052183-bc01eee1a74e?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',
  'https://images.unsplash.com/photo-1534232470104-d4188dec5137?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',
  'https://images.unsplash.com/photo-1529604278261-8bfcdb00a7b9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80',
  'https://images.unsplash.com/photo-1501817931860-6b22e34ca1a8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1108&q=80',
  'https://images.unsplash.com/photo-1482112048165-dd23f81c367d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'
]

ADDRESS = [
  '16 Villa Gaudelet, 75011 Paris',
  '17 rue de Lancry, 75010 Paris',
  '8 rue Bichat, 75010 Paris',
  '6 rue Jacques Louvel Tessier, 75010 Paris',
  '5 rue Traversière, 75012 Paris'
]

##
# User DB Seed
20.times do
  User.create!(
    email: Faker::Internet.email,
    password: "coucou"
  )
end
puts "20 users have been seeded.".green

##
# Bar DB Seed
User.all.sample(10).each do |user|
  bar = Bar.new(
    owner: user,
    name: Faker::Restaurant.name,
    address: ADDRESS.sample,
    price: rand(25..100),
    description: Faker::Restaurant.description,
    capacity: rand(10..150),
    opening_start: rand(9..20),
    opening_end: rand(21..23)
  )

  rand(3..6).times do |i|
    file = URI.open(BAR_PICTURES.sample)
    bar.photos.attach(io: file, filename: "bar_#{bar.id}_#{i}.png", content_type: 'image/png')
  end
  puts "A bar with #{bar.photos.count} photo(s) was created".blue
  bar.save!
end
puts "10 bars have been created".green

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
puts "15 bookings have been created".green

Booking.first.user = User.first
Booking.first.bar = Bar.first

comments = [
  { content: "C'était super !", rating: 4 },
  { content: "C'était pas si super !", rating: 3 },
  { content: "C'était super pas bien !", rating: 1 },
  { content: "C'était super je crois !", rating: 5 },
  { content: "C'était super terrible !", rating: 4 },
  { content: "C'était super pas terrible!", rating: 1 }
]

Booking.all.each do |booking|
  review = Review.new(comments.sample)
  review.booking = booking
  review.save!
end
puts "Reviews added to booking".green
