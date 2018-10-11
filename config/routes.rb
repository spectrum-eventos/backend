# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  scope :v1 do
    # Routes for Admins with devise
    mount_devise_token_auth_for 'Admin', at: 'auth/admin', controllers: {
      sessions: 'v1/auth/admins/sessions',
      registrations: 'v1/auth/admins/registrations',
      passwords: 'v1/auth/admins/passwords'
    }
    as :admin do
    end
  end

  namespace :v1 do
    resources :admins, except: %i[new edit]
    resources :events, except: %i[new edit]
    resources :lists, except: %i[new edit]
    resources :presences, except: %i[new edit]
  end

  resources :docs, only: [:index]

  # Errors
  match '*unmatched_route', to: 'application#raise_not_found!', via: %i[get post]
end
