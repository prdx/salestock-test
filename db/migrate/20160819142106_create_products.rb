class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :stock
      t.integer :quantity
      t.timestamps
    end
  end
end
