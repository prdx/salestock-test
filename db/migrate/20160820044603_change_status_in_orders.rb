class ChangeStatusInOrders < ActiveRecord::Migration[5.0]
  def change
    change_column_default :orders, :status, from: '', to: 'INITIATED'
  end
end
