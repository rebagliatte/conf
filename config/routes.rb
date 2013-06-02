Conf::Application.routes.draw do

  namespace :admin do
    resources :conferences, only: %w(show index new create edit update)
    match '/' => 'conferences#index'
  end

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :conferences, only: %w(index)

    resources :conference_editions, only: %w(index) do
      resources :posts, only: %w(index show)
      resources :speakers, only: %w(index)
      resources :slots, only: %w(index)
      resources :sponsors, only: %w(index)
      resources :talks, only: %w(index show new create edit update)
    end

    root to: 'conferences#index'
  end

  # Authentication
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: redirect('/')
  match '/logout', to: 'sessions#destroy', as: 'logout'

  # Subdomains
  constraints(Subdomain) do
    match '/' => 'conferences#show'
  end

  # I18N
  match '', to: redirect("/#{I18n.default_locale}")
end
