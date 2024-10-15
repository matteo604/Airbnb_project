# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# image urls from unsplash


require 'open-uri'

puts 'Cleaning database...'

Booking.destroy_all
Property.destroy_all
User.destroy_all


# create 2 users
puts 'Creating users...'
alice = User.create(
  email: 'alice.smith@example.com',
  password: 'SecurePassword123',
  password_confirmation: 'SecurePassword123',
  first_name: 'Alice',
  last_name: 'Smith',
  address: '123 Main Street',
  telephone_number: '1234567890'
)
puts "Created Alice as a user!"

john = User.create(
  email: 'john.doe@example.com',
  password: 'AnotherSecurePassword123',
  password_confirmation: 'AnotherSecurePassword123',
  first_name: 'John',
  last_name: 'Doe',
  address: '13 Somewhere Street',
  telephone_number: '1234567820'
)
puts "Created John as a user!"

# Create 3 properties
puts "Creating 3 properties which will be owned by Alice..."
parisFlat = Property.create(
  user_id: alice.id,
  price_per_night: 60.00,
  title: 'Cozy flat in Paris',
  description: 'A lovely place to stay with beautiful views.',
  location: '123 rue du loup, Paris',
  max_guests: 2,
  property_type: 'flat'
)
parisFlat.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "367058212.jpg")),
  filename: "367058212.jpg",
  content_type: "image/jpg"
)


berlinFlat = Property.create(
  user_id: alice.id,
  price_per_night: 65.00,
  title: 'Beautiful Berlin townhouse',
  description: 'Super central close to all the high street shops.',
  location: '54 Mailinger Strasse, Berlin',
  max_guests: 2,
  property_type: 'flat'
)

berlinFlat.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "367058212.jpg")),
  filename: "367058212.jpg",
  content_type: "image/jpg"
)

londonFlat = Property.create(
  user_id: alice.id,
  price_per_night: 80.00,
  title: 'Stunning 2 bedroom flat in London',
  description: 'A comfortable 2 bedroom flat in heart of London.',
  location: '10 Park Avenue, London',
  max_guests: 2,
  property_type: 'flat'
)

londonFlat.photo.attach(
  io: File.open(Rails.root.join("app", "assets", "images", "367058212.jpg")),
  filename: "367058212.jpg",
  content_type: "image/jpg"
)

puts "Properties Created!"

# Create Bookings
bookingParis = Booking.create(
  user_id: john.id,
  property_id: parisFlat.id,
  start_date: Date.today,
  end_date: Date.today + 7.days,
  number_of_guests: 2,
  total_price: parisFlat.price_per_night * 7
)
puts "John just made 1 booking in the flat in Paris..."

bookingBerlin = Booking.create(
  user_id: john.id,
  property_id: berlinFlat.id,
  start_date: Date.today - 3.days,
  end_date: Date.today,
  number_of_guests: 2,
  total_price: berlinFlat.price_per_night * 3
)
puts "John just made another booking, this time in Berlin..."

# create some reviews
reviewBerlin = Review.create(
  booking_id: bookingBerlin.id,
  user_id: john.id,
  property_id: berlinFlat.id,
  content: "The place was wonderful, with a beautiful view and excellent service!",
  rating: 4
)
puts "John made a review for his stay in Berlin"
