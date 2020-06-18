Rails.application.routes.draw do
  get 'animals/search', to: 'animals#search', as: 'search'

  devise_for :users
  root to: 'animals#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :animals, only: [ :destroy, :index, :show, :new, :create, :update ] do 

    resources :bookings, only: [ :index, :show, :new, :create ]
  end
end
