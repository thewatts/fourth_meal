OnoBurrito::Application.routes.draw do

  root :to => "restaurants#index"

  get "/log_out" => "sessions#destroy"
  get "/log_in" => "sessions#new", as: "log_in"
  get "/sign_up" => "users#new"

  resources :users
  resources :sessions
  resources :restaurants


  scope ":restaurant" do
    get '/' => 'items#index', as: :restaurant_root
    get 'menu' => 'items#index', as: :menu

    resources :items do
      :item_categories
    end
    resources :categories
    get "menu/:category_slug" => "items#in_category", as: "menu_items"
    
    resource :cart
    
    resources :orders
    resources :order_items
    resources :line_items
    resources :contacts
    resources :locations
    resources :transactions, only: [:new, :create, :show]

    namespace :admin do
      get "/" => "admin#index"
      resources :orders
      resources :items
    end

  end


end
