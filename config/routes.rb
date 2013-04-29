Conf::Application.routes.draw do

  resources :conference_editions, only: %w(index show) do
    resources :sponsors, only: %w(index)
    resources :speakers, only: %w(index)
  end

  # Authentication
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: redirect('/')
  match '/logout', to: 'sessions#destroy', as: 'logout'

  root to: 'pages#home'

  ActiveAdmin.routes(self)
end
