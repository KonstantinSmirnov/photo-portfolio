Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  get '/' => 'home#index'
  get 'portfolio' => 'portfolios#show'
  get 'contact' => 'contacts#show'
  post 'contact' => 'contacts#create'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :projects, only: [:show]

  namespace :admin do
    get 'dashboard' => 'dashboard#index'
    get 'account' => 'account#index'
    patch 'account' => 'account#update'
    resources :hero_carousel_slides
    delete 'remove_new_slide_form' => 'hero_carousel_slides#remove_new_form'
    resource :about do
      get 'cancel' => 'abouts#cancel'
    end
    resource :instagram do
      get 'cancel' => 'instagrams#cancel'
      get 'access_token' => 'instagrams#access_token'
    end
    resource :portfolio do
      get 'cancel' => 'portfolios#cancel'
    end
    resources :categories, except: [:index] do
      get 'cancel' => 'categories#cancel'
      delete 'remove_new' => 'categories#remove_new_form'
    end
    resources :projects do
      get 'cancel' => 'projects#cancel'
      resources :photos
      delete 'remove_new_photo' => 'photos#remove_new_form'
    end
    resources :opinions
    delete 'remove_new_opinion_form' => 'opinions#remove_new_form'
    resource :contact do
      get 'cancel' => 'contacts#cancel'
    end
  end

end
