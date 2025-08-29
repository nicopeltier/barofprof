# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create admin user
admin_user = User.find_or_create_by!(email: "nicolas.peltier@gmail.com") do |user|
  user.password = "12345678"
  user.password_confirmation = "12345678"
end

# Ensure user is admin
admin_user.update!(admin: true)

puts "Admin user created: #{admin_user.email}"
