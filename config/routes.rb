Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: "callbacks", registrations: 'users/registrations' }
  root 'welcome#index'

  resources :recipes do
    resources :notes
  end

  match 'search(/:search)', :to => 'recipes#index', :as => :search, via: [:get, :post]
  
end
