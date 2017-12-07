Rails.application.routes.draw do
  resources :bookings
  resources :photos
  get 'users/:username', to: "users#show", as: 'user'
  get '/venues/:id', to:'venues#show', as: 'venue'

  resources :venues do
    resources :bookings, only: [:index, :show, :new]
  end
  
  resources :clients do 
    resources :bookings, only: [:index, :show, :new]
  end
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
  get '/venues/:id/client_list', to: 'venues#client_list', as: 'client_list'
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
