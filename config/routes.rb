Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  get 'home/index', as: 'index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  namespace :admin do
    get 'dashboard' => 'dashboard#index'
    get 'account' => 'account#index'
    patch 'account' => 'account#update'
    resources :hero_carousel_slides
    delete 'remove_new_form' => 'hero_carousel_slides#remove_new_form'
  end

end
