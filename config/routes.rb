Rails.application.routes.draw do
  resource :posts
  root 'posts#index'
end
