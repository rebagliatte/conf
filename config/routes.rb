Conf::Application.routes.draw do

  resources :conference_editions

  # Authentication
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: redirect('/')
  match '/logout', to: 'sessions#destroy', as: 'logout'

  root to: 'pages#home'

  ActiveAdmin.routes(self)
end
