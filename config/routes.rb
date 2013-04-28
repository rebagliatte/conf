Conf::Application.routes.draw do
  resources :conference_editions

  # Authentication
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: redirect('/')
  match '/logout', to: 'sessions#destroy', as: 'logout'

  root to: 'conference_editions#show'

  ActiveAdmin.routes(self)
end
