class AddPaymentProofInOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :payment_proof, :string
  end
end
