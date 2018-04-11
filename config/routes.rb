Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  namespace :api do
    get 'properties', to: 'properties#index'
    get 'cities/:city', to: 'properties#city'
    resources :agents, only: [:index, :show]
    get 'buyers/:id', to: 'buyers#show'
    get 'properties/city_cost', to: 'properties#city_cost'
  end

  #Do not place any routes below this one
  get '*other', to: 'static#index'
end
