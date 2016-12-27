Rails.application.routes.draw do
  get "sessions/new"
  
  get "users/new"
  root "static_pages#home"
  get  "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get    "/login", to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    resources :categorys, only: [:new,:create,:index, :destroy, :show]
    resources :products
    resources :csv, only: :create
  end
  resources :users
  resources :products, only: [:index, :show]
  resources :carts
  resources :categorys,          only: [:new,:create,:index, :destroy, :show]
end
