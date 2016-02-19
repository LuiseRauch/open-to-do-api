Rails.application.routes.draw do
  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'

  namespace :api, defaults: { format: :json } do
    resources :users do
      # api/user/:user_id/lists/
      resources :lists
    end
    resources :lists, only: [] do
      resources :items, only: [ :create, :update ]
    end
    # api/items
    resources :items, only: [ :destroy, :index ]
  end

end
