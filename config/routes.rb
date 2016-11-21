Rails.application.routes.draw do
  root 'recipes#index'

  resource :recipes
  get '/recipes' => 'recipes#index'
end
