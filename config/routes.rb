Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "staticpages#top"
  get "/terms_of_service" => "staticpages#terms"
  get "/privacy_policy" => "staticpages#policy"

  resources :users
end
