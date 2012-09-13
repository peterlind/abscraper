Abscraper::Application.routes.draw do
  resources :queries, only: [:show, :create, :index], path: ''
  root to: 'queries#index'
end
