Rails.application.routes.draw do
  root 'static_pages#home'

  get    '/contact',            to: 'static_pages#contact', as: :contact
  get    '/faq',                to: 'static_pages#faq',     as: :faq

  get    'twitch/sign_in',      to: 'twitch#to_twitch',     as: :to_twitch
  get    'twitch/auth',         to: 'twitch#from_twitch',   as: :twitch_auth
  delete 'twitch/sign_out',     to: 'twitch#sign_out',      as: :sign_out

  get    'twitch/salty',        to: 'users#salty',          as: :salty
  get    'twitch/salty/',       to: 'users#edit',           as: :edit_salty
  patch  'twitch/salty/update', to: 'users#update',         as: :update_salty

end
