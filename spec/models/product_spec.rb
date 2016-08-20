require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is not valid if product_name is empty' do
    product = FactoryGirl.build(:product, product_name: nil)
    expect(product).to_not be_valid
  end

  it 'is not valid if code is empty' do
    product = FactoryGirl.build(:product, quantity: nil)
    expect(product).to_not be_valid
  end
end
