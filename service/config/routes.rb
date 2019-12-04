Rails.application.routes.draw do
  get 'home/index'

  resources :basket
  resources :item

  root 'home#index'

end
