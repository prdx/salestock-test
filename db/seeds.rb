# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FactoryGirl.define do
  factory :valid_product, class: Product do
    product_name "Cool Tees"
    quantity 10
    prize 2500000
  end

  factory :invalid_product, class: Product do
    product_name "Cool Tees"
    quantity 0
    prize 2500000
  end

  factory :percent_coupon, class: Coupon do
    code "XYX"
    valid_until "2017-01-01"
    quantity 10
    discount 10
    discount_type "PERCENT"
  end

  factory :nominal_coupon, class: Coupon do 
    code "ABC"
    valid_until "2017-01-01"
    quantity 10
    discount 100000
    discount_type "NOMINAL"
  end

  factory :invalid_date_coupon, class: Coupon do 
    code "DEF"
    valid_until "1990-01-01"
    quantity 10
    discount 100000
    discount_type "NOMINAL"
  end

  factory :invalid_quantity_coupon, class: Coupon do 
    code "EFG"
    valid_until "2019-01-01"
    quantity 0
    discount 100000
    discount_type "NOMINAL"
  end

  factory :valid_order, class: Order do
    name 'Alice'
    address 'Wonderland 1'
    email 'dummy@mail.com'
    phone '+62111111'
  end
end

FactoryGirl.create(:valid_product)
FactoryGirl.create(:invalid_product)

FactoryGirl.create(:percent_coupon)
FactoryGirl.create(:nominal_coupon)
FactoryGirl.create(:invalid_date_coupon)
FactoryGirl.create(:invalid_quantity_coupon)

FactoryGirl.create(:valid_order)


