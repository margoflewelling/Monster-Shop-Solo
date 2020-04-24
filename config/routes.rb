Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

## new routes
  get "/merchants/new", to: "merchants#new"
  get "/merchants/:id", to: "merchants#show"
  get "/merchants", to: "merchants#index"
  post "/merchants", to: "merchants#create"

  resources :items, only: [:index, :show]
  resources :reviews, only: [:edit, :update, :destroy]

  get "/password/edit", to: "passwords#edit"
  patch "/password/update", to: "passwords#update"

  resources :orders, only: [:new, :update, :create, :destroy]

  namespace :merchant do
    resources :merchants, only: [:update, :destroy, :edit]
    resources :items, only: [:edit, :new, :create, :update, :destroy]
    get '/', to: "dashboard#index"
    get '/orders/:id', to: "dashboard#show"
    get '/:merchant_id/items', to: "items#index"
    patch '/items/:item_id/status', to: "items#status"   
    patch '/items/:order_id/:item_id/fulfillment', to: "items#fulfill"
    resources :discounts, only: [:index, :create, :destroy, :update]
    get '/discounts/:id', to: "discounts#edit"
  end

  namespace :admin do
    resources :users, only: [:show]
    resources :merchants, only: [:show, :index]
    get '/', to: 'dashboard#index'
    get '/users', to: 'users#user_names'
    patch '/users/:user_id/disable', to: 'users#disable'
    patch '/users/:user_id/enable', to: 'users#enable'
    patch '/merchants/:merchant_id/disable', to: 'merchants#disable'
    patch '/merchants/:merchant_id/enable', to: 'merchants#enable'
    get "users/:user_id/orders/:order_id", to: "orders#show"
  end

  namespace :user do
    get '/profile', to: "users#profile"
    get '/profile/edit', to: 'users#edit'
    patch '/profile', to: 'users#update'
    post '/profile', to: 'sessions#create'
    get "/profile/orders", to: "users#orders"
  end

  get "/profile/orders/:id", to: "orders#show"
  get '/login', to: 'sessions#new'
  get '/logout', to: 'users#logout'

  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id/increment", to: "cart#increment"
  patch "/cart/:item_id/decrement", to: "cart#decrement"

  get '/register', to: "users#new"
  post '/register', to: "users#create"

end
