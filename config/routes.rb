OnoBurrito::Application.routes.draw do
  get "/log_out" => "sessions#destroy"
  get "/log_in" => "sessions#new", as: "log_in"
  get "/sign_up" => "users#new"

  resources :users
  resources :sessions
  resources :restaurants
  root :to => "restaurants#index"


  scope ":restaurant" do
    resources :contacts
    resources :items do
      :item_categories
    end
    resources :locations
    resources :orders
    resources :order_items
    get '/transactions/guest' => 'transactions#checkout_as_guest', as: "guest_transaction"
    resources :transactions, only: [:new, :create, :show]
    resources :admin_orders
    resources :admin_items
    get 'menu' => 'items#index', as: :menu
    get '/' => 'items#index', as: :restaurant_root
    get "menu/:category_slug" => "items#in_category", as: "menu_items"
    get "/admin" => "admin#index"
  end

  namespace :admin do
    get '/' => "dashboard#index", as: :admin

    # get '/edit' => "dashboards#edit", as: :edit_store
    # put '/update' => "dashboards#update", as: :update_store

    # post '/role' => "roles#create", as: :create_role
    # delete '/role' => "roles#destroy", as: :revoke_role

    # get :dashboard, to: "orders#index", as: :dashboard

    # resources :products do
    #   member do
    #     post :toggle_status
    #   end
    # end

    # resources :orders, only: [ :show, :update ]
    # resources :order_items, only: [ :update, :destroy ]
    # resources :categories, except: [ :show ]
  end


end
