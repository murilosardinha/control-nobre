Rails.application.routes.draw do
  resources :sales
  devise_for :users, controllers: { sessions: 'users/sessions' }
  
  root to: 'home#index'
  
  resources :users do
    get :edit_password, on: :member
  end
  
  resources :categories
  resources :filials do
    resources :users
    resources :damaged_items
    
    resources :expenses do
      get :report, on: :collection
    end

    resources :destinations

    resources :sales do
      # #INDEX entrada de mercadoria
      get :entrances, on: :collection
      get :report, on: :collection

      get :consult, on: :member
    end
    
    resources :epis do
      get :edit_limited, on: :member
      get :print, on: :member
      
      get :report, on: :collection
    end

    resources :products do
      get :edit_limited, on: :member
      get :print, on: :member
      
      get :report, on: :collection
    end
    
    resources :machines do
      resources :items do
        resources :similars
      end

      get :report, on: :collection
    end
  end
  
  # API
  namespace :api, defaults: { format: :json } do
    get '/products', to: 'products#index'
    post '/products', to: 'products#orders'
    post '/create_products', to: 'products#create_products'
    
    get '/sales', to: 'sales#show'
    post '/sales', to: 'sales#receive'
  end
end
