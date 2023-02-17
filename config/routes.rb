Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  namespace :admin do
      resources :users
      resources :inventories
      resources :invoices
      resources :items
      resources :roles, only: [:index, :show]

      root to: "users#index"
  end
  devise_for :users
  get 'invoices/index'
  get 'invoices/invoicecart/:id', :to => 'invoices#invoicecart'
  root 'inventories#index'
  
  resources :inventories do
    resources :items do
      resources :invoices
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :user
      resources :inventories
    end
  end
end
