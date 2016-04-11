Rails.application.routes.draw do
  root 'packages#index'
  get 'packages/:id' => 'packages#show', as: :package
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
