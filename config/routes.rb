Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :dashboards, only: [:index]
    resources :users, only: [:destroy]
    resources :categories, only: [:index, :edit, :update, :destroy]
  end

  scope module: :public do
    root to: "homes#top"
    devise_for :users
    devise_scope :user do
      post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    end

    resources :posts do
      collection do
        get "ranks" => "ranks#rank"
      end
      resources :comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
    end

    resources :animals, only: [:show, :edit, :update, :new, :create, :destroy]

    resources :users, only: [:index, :show, :edit, :update] do
      resources :animals, only: [:index]
      resources :favorites, only: [:index]
      resources :relationships, only: [:create, :destroy]
      get "following_users" => "relationships#following", as: "following"
      get "followed_users" => "relationships#followed", as: "followed"
    end

    resources :categories, only: [:create, :index, :show]
  end

end
