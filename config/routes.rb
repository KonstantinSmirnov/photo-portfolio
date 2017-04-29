Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  get '/' => 'home#index'
  get 'portfolio' => 'projects#index'
  get 'contact' => 'contacts#show'
  post 'contact' => 'contacts#create'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  namespace :admin do
    get 'dashboard' => 'dashboard#index'
    get 'account' => 'account#index'
    patch 'account' => 'account#update'
    resources :hero_carousel_slides
    delete 'remove_new_form' => 'hero_carousel_slides#remove_new_form'
    resource :about do
      get 'cancel' => 'abouts#cancel'
    end
    resource :instagram do
      get 'cancel' => 'instagrams#cancel'
      get 'access_token' => 'instagrams#access_token'
    end
    resources :projects do
      get 'cancel' => 'projects#cancel'
      resources :photos
    end
    resource :contact do
      get 'cancel' => 'contacts#cancel'
    end
  end

end
