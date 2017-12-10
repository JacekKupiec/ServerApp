Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'users/', to: 'users#create'
  get 'users/refresh', to: 'users#refresh'
  post 'users/log_in', to: 'users#log_in'
  get 'users/get_products', to: 'users#get_products'

  post 'products/', to: 'products#add_product'
  delete 'products/:id', to: 'products#delete_product'

  patch 'products/decrease_amount/:id/:delta', to: 'products#decrease_amount'
  put 'products/decrease_amount/:id/:delta', to: 'products#decrease_amount'
  patch 'products/increase_amount/:id/:delta', to: 'products#increase_amount'
  put 'products/increase_amount/:id/:delta', to: 'products#increase_amount'
  get 'products/:id', to: 'products#show'
end
