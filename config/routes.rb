Abscraper::Application.routes.draw do
  resources :queries, only: [:show]
  root to: 'queries#show'
end
