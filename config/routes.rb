Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: "search#show"
        get 'find_all', to: "search#index"
        get 'most_revenue', to: "most_revenue#index"
        get 'most_items', to: "most_items#index"
        get 'revenue', to: "revenue#index"
        get '/:id/revenue', to: 'revenue#show'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/customers_with_pending_invoices', to: 'customers_with_pending_invoices#index'
      end

      resources :customers, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]

    end
  end
end
