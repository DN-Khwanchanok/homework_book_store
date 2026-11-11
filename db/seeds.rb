# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin_email = ENV["ADMIN_EMAIL"]

if admin_email.present?
  admin = User.find_or_initialize_by(email_address: admin_email)
  admin.admin = true

  if admin.new_record?
    admin.password = ENV.fetch("ADMIN_PASSWORD")
  end

  admin.save!
  puts "บัญชี Admin พร้อมใช้งาน: #{admin.email_address}"
end
