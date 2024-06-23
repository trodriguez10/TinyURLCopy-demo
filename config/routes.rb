Rails.application.routes.draw do
  root 'urls#new'

  resources :urls, only: [:create]
  get '/:token', to: 'urls#show', as: :url
  get '/:token/info', to: 'urls#info', as: :url_info
end
