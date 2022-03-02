Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  
  root to: 'home#index'
  
  resources :users do
    get :edit_password, on: :member
  end
  
  resources :filials do
    resources :users
    resources :products
    resources :expenses
    
    resources :equipments do
      resources :items
      resources :references
    end

  end

end
