Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  
  root to: 'home#index'
  
  resources :users do
    get :edit_password, on: :member
  end
  
  resources :filials do
    resources :users
    resources :expenses
    resources :products do
      get :edit_limited, on: :member
    end
    
    resources :machines do
      resources :items do
        resources :similars
      end
    end
  end
end
