Mercadinho::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'
  end

  get "dashboard/index"
  resources :products do
    collection do
      get 'find_products' => 'products#find_products'
    end
  end
  resources :vendors do
    collection do
      get 'find_vendors' => 'vendors#find_vendors'
    end
  end
  resources :clients do
    collection do
      get 'find_clients' => 'clients#find_clients'
      get 'find_client_by_full_name' => 'clients#find_client_by_full_name'
    end
  end
  resources :cards
  resources :purchases
  resources :orders

  root 'dashboard#index'

end
