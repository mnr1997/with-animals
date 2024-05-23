Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  devise_for :users
  
  resources :posts, only: [:new, :create, :index, :show, :edit]
  resources :users, only: [:index, :show, :edit, :confirm]
  
end
