class AddShippingToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :shipping_id, :string
    add_column :orders, :shipping_partner, :string
    add_column :orders, :shipping_status, :string
  end
end
