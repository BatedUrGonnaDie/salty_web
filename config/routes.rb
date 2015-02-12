Rails.application.routes.draw do
  root  'static_pages#home'

  get   '/contact',                   to: 'static_pages#contact',   as: :contact
  get   '/faq',                       to: 'static_pages#faq',       as: :faq


  get   'twitch/salty/sign_in',       to: 'twitch#to_twitch',       as: :to_twitch
  get   'twitch/salty/auth',          to: 'twitch#from_twitch',     as: :twitch_auth
  get   'twitch/salty/sign_out',      to: 'twitch#sign_out',        as: :sign_out

  get   'twitch/salty',               to: 'users#salty',            as: :salty
  patch 'twitch/salty/update',        to: 'users#update',           as: :update_salty
  get   'twitch/salty/quotes',        to: 'users#quotes',           as: :salty_quotes
  patch 'twitch/salty/quotes/update', to: 'users#q_update',         as: :update_salty_quotes


  get   'twitch/dashboard/out',       to: 'dashboard#to_twitch',    as: :dashboard_out
  get   'twitch/dashboard/auth',      to: 'dashboard#from_twitch',  as: :dashboard_auth

  get   'twitch/dashboard',           to: 'dashboard#dashboard',    as: :dashboard

  # API Stuff
  namespace :api do
    resources :user, only: [] do
      resources :quotes, only: [:index, :create]
      resources :puns, only: [:index, :create]
      resources :songs, only: [:index, :create]
    end
  end
end
