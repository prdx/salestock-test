class AddDiscountedTotalPriceInOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :discounted_total_prize, :integer
  end
end
