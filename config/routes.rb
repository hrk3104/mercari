Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

 
  get 'mercari/index' => 'mercari#index'
  get 'mercari/link' => 'mercari#link'
  resources :items do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy, :edit, :update]
    post :upload_image, on: :collection
  end
   root 'mercari#index'
end
