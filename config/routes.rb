Rails.application.routes.draw do
  # Admin
  namespace :admin do
    resources :conferences do
      resources :conference_editions, only: %w(show new create edit update) do
        member do
          get :appearance
          get :edit_appearance
          patch :update_appearance

          get :call_for_proposals
          patch :update_call_for_proposals

          get :call_for_sponsors
          patch :update_call_for_sponsors

          get :registration_settings
          patch :update_registration_settings

          get :subscriber_settings
          patch :update_subscriber_settings

          patch :update_schedule_settings
        end
      end
    end

    resources :conference_editions do
      resources :images, only: %w(new create) do
        member do
          patch :destroy
        end
      end
      resources :organizers
      resources :talks do
        member do
          post :vote
          put :vote
        end
      end
      resources :notifications do
        member do
          get :preview
          get :trigger
        end
      end
      resources :speakers
      resources :sponsors
      resources :sponsor_contacts, only: %w(create edit update)
      resources :pages
      resources :posts
      resources :subscribers, only: %w(index)
      resources :slots
      resources :tickets
      resources :codes
    end

    root 'conferences#index'
  end

  # Public site
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :conferences, only: %w(index show)

    resources :conference_editions, path: 'editions', param: :slug do
      resources :pages, only: %w(show)
      resources :posts, only: %w(index show)
      resources :speakers, only: %w(index)
      resources :slots, only: %w(index)
      resources :sponsors, only: %w(index)
      resources :talks, path: 'sessions'
      resources :subscribers, only: %w(create)
    end

    # Conditional root
    get '/', to: 'marketing#home', constraints: RootConstraint.new
    root to: 'conferences#show'
  end

  # Authentication


  resources :users, only: %w(create)
  resources :sessions, only: %w(new create destroy)
  get 'logout', to: 'sessions#destroy', as: :logout
  get 'signup', to: 'sessions#new', as: :signup
  get '/signup/:organizer_invitation_token', to: 'sessions#new', as: :new_organizer_signup
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')

  # I18N
  get '', to: redirect("/#{I18n.default_locale}")

  # Unmatched routes
  get '*unmatched_route', to: 'application#not_found'
end
