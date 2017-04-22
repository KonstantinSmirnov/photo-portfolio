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
    patch 'user' => 'account#update'
  end

end
