Rails.application.routes.draw do
  resources :transactions
  resources :merchants
  resources :venues do
    resources :reservations do
      get 'confirmation', on: :collection
      member do
        get 'save_session'
      end
    end
  end
  
  resources :events
  resources :bookings
  resources :photos
  get 'users/:username', to: "users#show", as: 'user'


  resources :clients do 
    resources :bookings, only: [:index, :show, :new]
  end


  resources :tweets #Always seven
  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }
  
  resources :merchants do
    resources :venues
    resources :transactions
  end

  resources :users do
    resources :merchants
    resources :transactions
  end

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
