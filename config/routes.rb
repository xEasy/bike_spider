Rails.application.routes.draw do
  resources :posts, only: [:index]
  resources :favorities
  get 'dashboard' => 'home#dashboard'
  root 'posts#index'
end
