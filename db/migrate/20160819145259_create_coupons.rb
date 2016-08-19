class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.datetime :valid_until
      t.integer :quantity

      t.timestamps
    end
  end
end
