require 'rails_helper'

RSpec.describe CouponController, type: :controller do
  it 'sends list of coupons' do
    get :index
    expect(response).to be_success
  end
end
