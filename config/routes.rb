Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts, only: [:index, :new, :create] do
    member do
      get "create_like"
    end
  end
  resources :users, only: :show do
    member do
      get "follow"
    end
  end
end
