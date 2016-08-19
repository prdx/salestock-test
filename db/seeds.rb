# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FactoryGirl.define do
  factory :product do
    product_name "Cool Tees"
    quantity 10
    prize 2500000
  end

  factory :coupon do
    code "XYX"
    valid_until "2017-01-01"
    quantity 10
    discount 10
    discount_type "PERCENT"
  end
end

FactoryGirl.create(:product)
FactoryGirl.create(:coupon)

