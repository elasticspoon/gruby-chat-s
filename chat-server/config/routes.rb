Rails.application.routes.draw do
  resources :messages, only: [:create, :destroy, :show]
  devise_for :users
  resources :chat_rooms, only: %i[index show create destroy]
  post "/chat_rooms/:id/user_location/:user_id", to: "chat_rooms#user_location", as: "user_location"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  root "chat_rooms#index"
end
