# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      get '/items/find_all', to: 'items#find_all'
      get '/revenue/merchants', to: 'revenues#top_merchants'
      resources :merchants, only: %i[index show] do
        resources :items, only: [:index], controller: :merchant_items
      end
      resources :items, only: %i[index show]
      resources :items, only: %i[index show]
    end
  end
end
