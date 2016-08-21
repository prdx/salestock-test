Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :product
  resources :order
  resources :coupon

  scope :order, as: :order do
    post '/add', to: 'order#add_orderline'
    get '/checkout/:id', to: 'order#checkout'
    get 'shipment/:id', to: 'order#search_shipment'
    put 'payment(.:format)', to: 'order#submit_proof'
    put 'shipment(.:format)', to: 'order#submit_shipment'
  end
end
