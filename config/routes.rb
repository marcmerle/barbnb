# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  get '/dashboard', to: redirect("/dashboard/bookings")
  get '/dashboard/bookings', to: 'bookings#index', as: "dashboard_bookings"
  get '/dashboard/bars', to: 'bars#owner_index', as: "dashboard_bars"

  resources :bars, except: :destroy do
    resources :bookings, only: %i[create]
    resources :reviews, only: %i[create]
  end
  resources :bookings, except: %i[index create]
end
