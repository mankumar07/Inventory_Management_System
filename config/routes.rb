# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  namespace :admin do
    resources :users
    resources :inventories
    resources :invoices
    resources :items
    resources :roles, only: %i[index show]

    root to: 'users#index'
  end
  devise_for :users
  get 'invoices/index'
  get 'invoices/invoicecart/:id', to: 'invoices#invoicecart'
  root 'inventories#index'
  get '/search', to: 'items#search'

  resources :inventories do
    resources :items do
      resources :invoices
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :user
      resources :inventories do
        resources :items
        resources :invoices
      end
    end
  end
end
