Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  get '/' => 'home#index'
  get 'contact' => 'contacts#show'
  post 'contact' => 'contacts#create'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :projects, only: [:show]
  resources :categories, only: [:index, :show]

  namespace :admin do
    get 'dashboard' => 'dashboard#index'
    get 'account' => 'account#index'
    patch 'account' => 'account#update'

    resources :hero_carousel_slides do
      collection { post :sort }
    end
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
      collection { post :sort }
      get 'cancel' => 'categories#cancel'
    end
    delete 'remove_new_category_form' => 'categories#remove_new_form'

    resources :projects do
      get 'cancel' => 'projects#cancel'
      resources :photos do
        collection { post :sort }
      end
      delete 'remove_new_photo' => 'photos#remove_new_form'
    end

    resources :opinions do
      collection { post :sort }
    end
    delete 'remove_new_opinion_form' => 'opinions#remove_new_form'

    resource :contact do
      get 'cancel' => 'contacts#cancel'
    end

    resource :setting
  end

  match "/404", :to => 'errors#error_404', via: :all

  get '/sitemap.xml', :to => 'sitemap#show', :format => 'xml', :as => :sitemap

  get '*url' => 'errors#error_404'

end
