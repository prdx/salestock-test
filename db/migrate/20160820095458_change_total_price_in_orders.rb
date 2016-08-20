class ChangeTotalPriceInOrders < ActiveRecord::Migration[5.0]
  def change
    change_column_default :orders, :total_prize, from: nil, to: 0
  end
end
