Rails.application.routes.draw do
  resources :posts, only: [:index]
  resources :favorities
  root 'posts#index'
end
