Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  get '/dashboard', to: 'bookings#index'

  resources :bars, except: :destroy
  resources :bookings, except: :index
end
