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
    resources :sales
    
    resources :products do
      get :edit_limited, on: :member
      get :entrances, on: :collection
    end
    
    resources :machines do
      resources :items do
        resources :similars
      end
    end
  end
end
