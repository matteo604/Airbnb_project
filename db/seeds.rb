# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts 'Cleaning database...'
User.destroy_all

puts 'Creating users...'
User.create(
  email: 'alice.smith@example.com',
  password: 'SecurePassword123',
  password_confirmation: 'SecurePassword123',
  first_name: 'Alice',
  last_name: 'Smith',
  address: '123 Main Street',
  telephone_number: '1234567890'
)
puts "Created Alice as a user..."

User.create(
  email: 'john.doe@example.com',
  password: 'AnotherSecurePassword123',
  password_confirmation: 'AnotherSecurePassword123',
  first_name: 'John',
  last_name: 'Doe',
  address: '13 Somewhere Street',
  telephone_number: '1234567820'
)
puts "Created John as a user..."
