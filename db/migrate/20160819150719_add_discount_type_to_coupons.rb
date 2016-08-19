class AddDiscountTypeToCoupons < ActiveRecord::Migration[5.0]
  def change
    add_column :coupons, :discount_type, :string
  end
end
