class ChangeDiscountedTotalPriceInOrders < ActiveRecord::Migration[5.0]
  def change
    change_column_default :orders, :discounted_total_prize, from: nil, to: 0
  end
end
