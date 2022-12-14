Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resource :home, only: :index
  root "home#index"

  resources :albums

  resources :albums do
    member do 
      delete :delete_photo_attachment
    end
  end
end
