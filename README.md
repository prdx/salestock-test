# Salestock Test 

Framework: Ruby on Rails 5

I make the Dockerfile in case you want to run it locally.
You can find it here: [salestock-test-docker](https://github.com/prdx/salestock-test-docker)


## Data
I provide the seed data for some cases, such as invalid product, invalid coupon, initial order. Please run `rake db:create db:migrate db:seed RAILS_ENV=production` `rake db:create db:migrate db:seed RAILS_ENV=development` `rake db:create db:migrate db:seed RAILS_ENV=test` first.

## Test
I am using RSpec. To run it you can always use `rspec` command in this project root folder.
If you are using [salestock-test-docker](https://github.com/prdx/salestock-test-docker), please refer to [the docker doc](https://github.com/prdx/salestock-test-docker/blob/master/README.md).

## Explanation
In Order I made statuses to show the flow of an transaction.

| Status | Explanation |
|--------|-------------|
| `INTIATED` | It means the order has already created in database but might not yet contains product |
| `PAYMENT_PROOF_REQUIRED` | It means user has finished their order and ready to submit the payment proof |
| `PAYMENT_PROOF_SUBMITTED` | It means that user has update their payment info thus admin can proceed to shipment |
| `SHIPPED` | Order is valid and the admin has inputted their shipment info |
| `CANCELLED` | Order is not valid and has been cancelled by Admin |

## Endpoints
| Endpoint | Explanation | Type |
|----------|-------------|------|
| `/order` | To view all orders | GET |
| `/coupon` | To view all coupons | GET |
| `/product` | To view all products | GET |
| `/order` | To post new product | POST |
| `/order/add` | To add product to order | POST |
| `/order/checkout/:id` | To checkout the order | GET |
| `/order/payment` | To submit payment proof | PUT |
| `order/shipment` | To submit the shipment info | PUT |
| `order/:id` | To search for order by its id | GET |
| `order/shipment/:id` | To search for the shipment status | GET |

## TODO
There are some todos remaining in this project:

|Todo |
------
| Move the controllers into module v1 |
| Authorization |
| Use enum for status to avoid mistype |





