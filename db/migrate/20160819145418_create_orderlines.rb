class CreateOrderlines < ActiveRecord::Migration[5.0]
  def change
    create_table :orderlines do |t|
      t.belongs_to :order
      t.belongs_to :product

      t.timestamps
    end
  end
end
