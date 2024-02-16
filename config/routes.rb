Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "staticpages#top"
  get "/terms_of_service" => "staticpages#terms"
  get "/privacy_policy" => "staticpages#policy"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'



  
  
  resources :users do
    get 'plants', to: 'users#search_index'

    post 'callback', to: 'users#callback'
    patch 'delete_line_id', to: 'users#delete_line_id'
  end


  resources :plants do
    collection do
      get 'search', to: 'plants#search'
    end
    member do
      patch 'watered', to: 'plants#watered'
    end
  end
end
