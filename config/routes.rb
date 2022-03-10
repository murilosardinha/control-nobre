Rails.application.routes.draw do
  resources :sales
  devise_for :users, controllers: { sessions: 'users/sessions' }
  
  root to: 'home#index'
  
  resources :users do
    get :edit_password, on: :member
  end
  
  resources :filials do
    resources :users
    resources :expenses
    resources :destinations
    resources :sales do
      # INDEX entrada de mercadoria
      get :entrances, on: :collection
    end
    
    resources :products do
      get :edit_limited, on: :member
      get :import, on: :collection
    end
    
    resources :machines do
      resources :items do
        resources :similars
      end
    end
  end

  # API
  namespace :api, defaults: { format: :json } do
    get '/products', to: 'products#index'
    post '/products', to: 'products#orders'
  end
end
