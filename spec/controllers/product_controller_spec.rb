require 'rails_helper'

RSpec.describe ProductController, type: :controller do
  context 'All Users' do
    it 'sends list of products' do
      get :index
      expect(response).to be_success
    end
  end
end
