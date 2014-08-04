Rails.application.routes.draw do
  # Admin
  namespace :admin do
    resources :conferences do
      resources :conference_editions, only: %w(show new create edit update) do
        member do
          get :appearance
          get :edit_appearance
          put :update_appearance
        end
      end
    end

    resources :conference_editions do
      resources :images, only: %w(new create) do
        member do
          put :destroy
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
    end

    root 'conferences#index'
  end

  # Public site
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :conferences, only: %w(index show)

    resources :conference_editions, only: %w(index) do
      resources :pages, only: %w(show)
      resources :posts, only: %w(index show)
      resources :speakers, only: %w(index)
      resources :slots, only: %w(index)
      resources :sponsors, only: %w(index)
      resources :talks
      resources :subscribers, only: %w(create)
    end

    # Conditional root
    get '/', to: 'marketing#home', constraints: RootConstraint.new
    root to: 'conferences#show'
  end

  # Authentication
  get '/signup' => 'sessions#new', as: :signup
  get '/signup/:organizer_invitation_token' => 'sessions#new', as: :new_organizer_signup
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy', as: 'logout'

  # I18N
  get '', to: redirect("/#{I18n.default_locale}")
end
