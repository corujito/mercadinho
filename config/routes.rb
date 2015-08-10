Mercadinho::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'
  end

  get "dashboard/index"
  resources :products
  resources :vendors
  resources :clients
  resources :cards
  resources :purchases

  root 'dashboard#index'

end
