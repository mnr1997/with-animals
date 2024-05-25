Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  devise_for :users

  resources :posts, only: [:new, :create, :index, :show, :edit] do
    collection do
      get :rank
    end
    resources :comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    get :favorite_posts, :following, :followed
    resources :animals, only: [:new, :create, :index, :show, :edit, :update]
    collection do
      get :confirm
    end
  end
  
  resources :categories, only: [:create, :index, :edit, :update]
  
end
