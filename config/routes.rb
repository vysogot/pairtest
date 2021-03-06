Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"

  resources :genres, only: :index do
    member do
      get "movies"
    end
  end

  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end

    collection do
      get :export
    end

    resources :comments, only: [:create, :destroy], shallow: true
  end

  resources :comments_ranking, only: [:index]

  namespace :movies_api, defaults: { format: :json } do
      namespace :v1 do
          resources :movies, only: [:index, :show]
      end

      namespace :v2 do
          resources :movies, only: [:index, :show]
      end
  end

  resources :remote_movies, only: :show, param: :title
end
