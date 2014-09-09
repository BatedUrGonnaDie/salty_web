Rails.application.routes.draw do
  root 'static_pages#home'

  get    '/contact',        to: 'static_pages#contact', as: :contact
  get    '/faq',            to: 'static_pages#faq',     as: :faq

  get    'twitch/sign_in',  to: 'twitch#to_twitch',     as: :to_twitch
  get    'twitch/auth',     to: 'twitch#from_twitch',   as: :twitch_auth
  get    'twitch/salty',    to: 'twitch#salty',         as: :salty
  delete 'twitch/sign_out', to: 'twitch#sign_out',      as: :sign_out
end
