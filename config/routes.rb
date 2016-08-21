Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :product
  resources :order
  resources :coupon

  scope :order, as: :order do
    post '/add', to: 'order#add_orderline'
    get '/checkout/:id', to: 'order#checkout'
    put 'payment(.:format)', to: 'order#submit_proof'
  end
end
