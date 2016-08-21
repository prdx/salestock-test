# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160821101117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.datetime "valid_until"
    t.integer  "quantity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "discount"
    t.string   "discount_type"
  end

  create_table "orderlines", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_orderlines_on_order_id", using: :btree
    t.index ["product_id"], name: "index_orderlines_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "status",                 default: "INITIATED"
    t.integer  "coupon_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "total_prize",            default: 0
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.integer  "discounted_total_prize", default: 0
    t.string   "payment_proof"
    t.string   "shipping_id"
    t.string   "shipping_partner"
    t.string   "shipping_status"
    t.index ["coupon_id"], name: "index_orders_on_coupon_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "product_name"
    t.string   "stock"
    t.integer  "quantity"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "prize"
  end

end
