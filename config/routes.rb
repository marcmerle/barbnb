# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  # UX redirections
  get '/dashboard', to: redirect("/dashboard/bookings")
  get '/dashboard/bars/:id', to: redirect("/dashboard/bars")

  get '/dashboard/bookings', to: 'bookings#index', as: "dashboard_bookings"
  get '/dashboard/bars', to: 'bars#owner_index', as: "dashboard_bars"
  get '/dashboard/bars/:bar_id/bookings', to: 'bookings#owner_index', as: "dashboard_owner_bookings"

  resources :bars, except: :destroy do
    resources :bookings, only: %i[create]
  end

  resources :bookings, except: %i[index create] do
    resources :reviews, only: %i[create]
  end

  post '/bookings/:id/cancellation', to: 'bookings#cancel', as: "booking_cancellation"
end
