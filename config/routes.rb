Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :edit, :update, :show]
  patch 'become_admin' => 'users#become_admin', :as => :become_admin

  resources :materials, except: :show do
    get :material_logs, to: 'material_logs#show'
  end

  get :material_logs, to: 'material_logs#index'


  resources :home, only: :index
  root to: 'home#index', :as => :root_app
end
