# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  get '/dashboard/bookings', to: 'bookings#index', as: "dashboard_bookings"

  resources :bars, except: :destroy do
    resources :bookings, only: %i[create]
    resources :reviews, only: %i[create]
  end
  resources :bookings, except: %i[index create]
end
