Rails.application.routes.draw do
  resources :venues
  resources :tweets #Always seven
  devise_for :users
  as :user do
  	get "signin" => 'devise/sessions#new'
  	delete "signout" => 'devise/sessions#destroy'
  	get "signup" => 'devise/registrations#new'
  end
  root "pages#home"
  get 'about' => 'pages#about'
  get 'contact_us' => 'pages#contact-us' # the latter is the FILE_NAME
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
