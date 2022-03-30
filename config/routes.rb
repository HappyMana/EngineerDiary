Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :posts do
    resource :likes, only: [:create, :destroy]
    collection do
      get :search
    end
  end
  resources :tags, only: [:new, :create]
  resources :users do
    collection do
      get 'likes'
      get 'search'
      get 'update'
    end
  end
  root 'posts#index'
  # get '/search' to 'posts#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
