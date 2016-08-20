FactoryGirl.define do
  factory :coupon do
    code 'XYZO'
    valid_until '2017-01-01 00:00'
    quantity 10
    discount 25
    discount_type 'PERCENT'
   end
end

