Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :admins, skip: [:registrations, :password], controllers: {
    sessions: "admin/admins/sessions",
  }
  
  namespace :admin do
    root to: "dashboards#top"
    resources :users, only: [:index, :destroy]
    resources :categories, only: [:index, :edit, :update, :destroy]
  end

  scope module: :public do
    root to: "homes#top"
    devise_for :users, skip: [:password], controllers: {
      sessions: "public/users/sessions",
      registrations: "public/users/registrations",
    }
    devise_scope :user do
      post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    end

    resources :posts do
      collection do
        resources :ranks, only: [:index]
      end
      resources :comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
    end

    resources :animals, only: [:show, :edit, :update, :new, :create, :destroy]

    resources :users, only: [:index, :show] do
      resources :animals, only: [:index]
      resources :favorites, only: [:index]
      resource :relationships, only: [:create, :destroy]
      # resources :following_users, only: [:index]
      # resources :followed_users, only: [:index]
      get "following_users" => "relationships#following", as: "following"
      get "followed_users" => "relationships#followed", as: "followed"
    end

    resources :categories, only: [:create, :index, :show]
  end
end
