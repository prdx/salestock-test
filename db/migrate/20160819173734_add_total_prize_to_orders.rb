class AddTotalPrizeToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :total_prize, :integer
  end
end
