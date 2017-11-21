Rails.application.routes.draw do
  resources :bookings
  resources :photos
  get 'users/:username', to: "users#show", as: 'user'

  resources :venues
  resources :tweets #Always seven
  devise_for :users
  as :user do
  	get "signin", to: 'devise/sessions#new'
  	delete "signout", to: 'devise/sessions#destroy'
  	get "signup", to:'devise/registrations#new'
  end
  root "pages#home"
  get 'adminv', to:'admins#admin'
  get 'about', to: 'pages#about'
  get 'contact_us', to: 'pages#contact-us' # the latter is the FILE_NAME
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
