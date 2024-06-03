Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :posts do
    collection do
      get :rank
    end
    resources :comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end

  resources :animals, only: [:show, :edit, :update, :new, :create]
  
  resources :users, only: [:index, :show, :edit, :update] do
    resources :animals, only: [:index]
    resources :favorites, only: [:index]
    resources :relationships, only: [:create, :destroy]
    get :following
    get :followed
    collection do
      get :confirm
    end
  end

  resources :categories, only: [:create, :index, :show, :edit, :update]
end
