require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products, only: [:index]

      namespace :files do
        post :upload
      end
    end
  end

  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end
end