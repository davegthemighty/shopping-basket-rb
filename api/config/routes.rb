Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :baskets
  resources :items

  put 'baskets/:basket_id/items/:item_id', :to => 'basketlines#add_item'
  delete 'baskets/:basket_id/items/:item_id', :to => 'basketlines#remove_item'

end
