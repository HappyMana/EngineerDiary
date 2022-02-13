Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'posts#index'
  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  get 'goods/index'
  get 'follows/index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
