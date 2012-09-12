Abscraper::Application.routes.draw do
  resources :queries, only: [:show]
end
