Rails.application.routes.draw do
  root  'static_pages#home'

  match '/404',                       to: 'errors#not_found',       as: :not_found,       via: :all
  match '/422',                       to: 'errors#unacceptable',    as: :unacceptable,    via: :all
  match '/500',                       to: 'errors#internal_error',  as: :internal_error,  via: :all

  get   '/contact',                   to: 'static_pages#contact',   as: :contact
  get   '/faq',                       to: 'static_pages#faq',       as: :faq

  get   'twitch/salty/sign_in',       to: 'twitch#to_twitch',       as: :to_twitch
  get   'twitch/salty/auth',          to: 'twitch#from_twitch',     as: :twitch_auth
  get   'twitch/salty/sign_out',      to: 'twitch#sign_out',        as: :sign_out

  get   'twitch/salty',               to: 'users#salty',            as: :salty
  patch 'twitch/salty',               to: 'users#update',           as: :update_salty
  get   'twitch/salty/quotes',        to: 'users#quotes',           as: :salty_quotes
  patch 'twitch/salty/quotes',        to: 'users#q_update',         as: :update_salty_quotes
  get   'twitch/salty/custom',        to: 'users#custom_commands',  as: :custom_commands
  patch 'twitch/salty/custom',        to: 'users#cc_update',        as: :update_custom_commands
  get   'twitch/salty/guide',         to: 'users#guide',            as: :salty_guide

  get   'twitch/pydash/out',          to: 'dashboard#to_twitch',    as: :dashboard_out
  get   'twitch/pydash/auth',         to: 'dashboard#from_twitch',  as: :dashboard_auth

  get   'twitch/pydash',              to: 'dashboard#dashboard',    as: :dashboard

  # API Stuff
  namespace :api do
    resources :users, only: [] do
      scope module: :users do
        resources :quotes, only: [:index, :create, :update, :destroy]
        resources :puns, only: [:index, :create, :update, :destroy]
        resources :custom_commands, only: [:create, :destroy]
        resources :songs, only: [:index, :create, :update]
      end
    end

    resources :songs, only: [:create]
  end
end
