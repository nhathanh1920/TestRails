Rails.application.routes.draw do
  get 'sessions/new'

  root 'posts#index'
  
  

  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
      resources :comments
    end
  end
  resources :posts do
    resources :comments
  end
  resources :relationships,       only: [:create, :destroy]
  
end
