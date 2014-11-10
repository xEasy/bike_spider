Rails.application.routes.draw do
  resources :posts, only: [:index, :update] do
    collection do
      get :fetch_all
      get :fetch_result
    end
  end
  resources :favorities
  get 'dashboard' => 'home#dashboard'
  root 'posts#index'
end
