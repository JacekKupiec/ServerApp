Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'users/', to: 'users#create'
  get 'users/refresh', to: 'users#refresh'
  post 'users/log_in', to: 'users#log_in'
  get 'users/get_products', to: 'users#get_products'
  get 'users/get_groups', to: 'users#get_groups'

  post 'products/', to: 'products#add_product'
  delete 'products/:id', to: 'products#delete_product'

  patch 'products/decrease_amount/:id/:delta', to: 'products#decrease_amount'
  put 'products/decrease_amount/:id/:delta', to: 'products#decrease_amount'
  patch 'products/increase_amount/:id/:delta', to: 'products#increase_amount'
  put 'products/increase_amount/:id/:delta', to: 'products#increase_amount'
  get 'products/:id', to: 'products#show'
  put 'products/sync_subsum/:id/:subsum', to: 'products#sync_subsum'

  post 'groups/', to: 'groups#create'
  delete 'groups/:id', to: 'groups#delete'
  put 'groups/add_product/:group_id/:product_id', to: 'groups#add_product'
  patch 'groups/add_product/:group_id/:product_id', to: 'groups#add_product'
  delete 'groups/remove_product/:group_id/:product_id', to: 'groups#remove_product'
  get 'groups/:id', to: 'groups#get_group'
end
