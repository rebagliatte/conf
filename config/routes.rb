Conf::Application.routes.draw do

  # Admin
  namespace :admin do
    resources :conferences, only: %w(show index new create edit update) do
      resources :conference_editions, only: %w(show new create edit update)
    end

    resources :conference_editions do
      resources :talks, only: %w(show index new create edit update)
      resources :speakers, only: %w(show index new create edit update)
      resources :sponsors, only: %w(show index new create edit update)
      resources :posts, only: %w(show index new create edit update)
    end

    match '/' => 'conferences#index'
  end

  # Public site
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :conferences, only: %w(index)

    constraints(Subdomain) do
      match '/' => 'conferences#show'
    end

    resources :conference_editions, only: %w(index) do
      resources :posts, only: %w(index show)
      resources :speakers, only: %w(index)
      resources :slots, only: %w(index)
      resources :sponsors, only: %w(index)
      resources :talks, only: %w(index show new create edit update)
      resources :subscribers, only: %w(create)
    end

    root to: 'marketing#home'
  end

  # Authentication
  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: redirect('/')
  match '/logout', to: 'sessions#destroy', as: 'logout'

  # I18N
  match '', to: redirect("/#{I18n.default_locale}")
end
