class AddPrizeToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :prize, :integer
  end
end
