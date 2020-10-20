Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do
      resources :devices do
        resources :bill_counts
        resources :bill_hists
        resources :dev_statuses
        resources :auth_params
      end
      resources :bill_counts
      resources :bill_hists
      resources :denoms, only: [:show, :index]
      resources :transactions
      resources :customer_barcodes
      resources :customers
      resources :dev_statuses, only: [:index]
      resources :status_descs, only: [:show, :index]
      resources :op_code_maps, only: [:index]
      resources :auth_params
    end
  end
  
  namespace :docs do
    namespace :v1 do
      get 'welcome/index'
      root 'welcome#index'
      resources :devices, only: [:index]
      resources :customers, only: [:index]
      resources :customer_barcodes, only: [:index]
      resources :transactions, only: [:index]
      resources :bill_counts, only: [:index]
      resources :bill_hists, only: [:index]
      resources :denoms, only: [:index]
    end
  end
  
end
