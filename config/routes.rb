Rails.application.routes.draw do
  root 'pages#home'

  get 'pages/about'
  get 'pages/contact' => 'pages#contact', as: :contact_us

  devise_for :users, controllers: { registrations: "registrations" }

  get 'flights' => 'flights#index'
  post "flights/search" => "flights#search"

  get 'bookings/search' => 'bookings#search', as: :search_booking
  get 'bookings/search_result' => 'bookings#search_result', as: :search_result
  get 'bookings/payment_success' => 'bookings#payment_success', as: :payment_success

  get 'bookings' => 'bookings#index', as: :bookings
  post 'bookings' => 'bookings#create'
  get 'bookings/new' => 'bookings#new', as: :new_booking
  get 'bookings/:id/edit' => 'bookings#edit', as: :edit_booking
  get 'bookings/:id' => 'bookings#show', as: :booking
  patch 'bookings/:id' => 'bookings#update'
  put 'bookings/:id' => 'bookings#update'
  delete 'bookings/:id' => 'bookings#destroy'
end
