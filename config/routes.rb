require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :urls, only: [:create]
  get '/:token', to: 'urls#show', as: :url
  get '/:token/info', to: 'urls#info', as: :url_info

  root 'urls#new'
end
