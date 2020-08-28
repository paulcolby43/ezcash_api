Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do
      resources :devices, only: [:show, :index]
      resources :bill_counts, only: [:show, :index]
      resources :bill_hists, only: [:show, :index]
      resources :denoms, only: [:show, :index]
      resources :transactions
      resources :customer_barcodes
    end
  end
  
end
