Rails.application.routes.draw do
  resources :prototypes do
    resources :comments, only: :create
  end
  devise_for :users
  resources :users, only: :show
  
  root to: "prototypes#index"
end

