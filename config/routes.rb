Rails.application.routes.draw do
  get 'animals/search', to: 'animals#search', as: 'search'

  devise_for :users
  root to: 'animals#index'

  resources :animals, only: [ :destroy, :index, :show, :new, :create, :update, :edit ] do 

    resources :bookings, only: [ :index, :show, :new, :create ]
  end
end
