Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"


 
  get 'mercari/index' => 'mercari#index'
  get 'mercari/link' => 'mercari#link'
  resources :items do
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy, :edit, :update]
  post "items/upload_image", to: "items#upload_image"
  get 'users' =>'users#index' 
  end
   root 'mercari#index'
end
