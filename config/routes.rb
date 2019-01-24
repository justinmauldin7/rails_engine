Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: "find#show"
        get 'most_revenue', to: "most_revenue#index"
      end

      resources :customers, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]

    end
  end
end
