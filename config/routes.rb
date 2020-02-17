Rails.application.routes.draw do
  get 'dashboards/:id', to: 'dashboards#show'
  get 'dashboards/:id/edit', to: 'dashboards#edit'
  patch 'dashboards/:id', to: 'dashboards#update'
  delete '/', to: 'dashbboards#delete'
  devise_for :users
  root to: 'pages#home'
  resources :bars, except: :destroy
  get 'bookings/show'
  get 'bookings/edit'
end
