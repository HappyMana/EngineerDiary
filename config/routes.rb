Rails.application.routes.draw do
  get 'comments/index'
  get 'goods/index'
  get 'follows/index'
  get 'posts/index'
  get 'posts/show'
  get 'posts/new'
  get 'posts/create'
  get 'posts/edit'
  get 'posts/update'
  get 'posts/destory'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
