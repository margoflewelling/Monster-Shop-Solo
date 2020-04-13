Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :merchants

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  delete "/items/:id", to: "items#destroy"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id/increment", to: "cart#increment"
  patch "/cart/:item_id/decrement", to: "cart#decrement"

  get "/orders/new", to: "orders#new"
  post "/orders", to: "orders#create"
  get "/orders/:id", to: "orders#show"
  delete "/orders/:id", to: "orders#destroy"

  get '/register', to: "users#new"
  post '/register', to: "users#create"


  # don't namespace - create the routes below
  # get '/profile', to: "users#show"
  # get '/profile/edit', to: 'users#edit'
  # patch '/profile', to: 'users#update'
  namespace :user do
    get '/profile', to: "users#profile" #'users#show'
    get '/profile/edit', to: 'users#edit'
    patch '/profile', to: 'users#update'
    post '/profile', to: 'sessions#create'
    get "/profile/orders", to: "users#orders"
  end

  resource :password, only: [:edit, :update]

  namespace :merchant do
    get '/', to: "dashboard#index"
    get '/orders/:id', to: "dashboard#index"
    get '/items', to: "items#index"
    patch '/items/:item_id', to: "items#update"
    delete '/items/:item_id', to: "items#destroy"
  end

  get '/login', to: 'sessions#new'
  get '/logout', to: 'users#logout'
  # post '/login', to: 'sessions#create'
  # post '/login', to: 'sessions#create'
  # delete '/logout', to 'sessions#destroy'

  namespace :admin do
    get '/', to: 'dashboard#index'
    get '/users', to: 'users#user_names'
    get '/merchants/:merchant_id', to: 'merchant#show'
    get '/merchants', to: 'merchant#index'
    patch '/merchant/disable', to: 'merchant#disable'
  end
end
