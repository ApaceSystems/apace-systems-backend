# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end
  match '/graphql', to: 'graphql#execute', via: %i[get post]

  # namespace :api do
  #  namespace :v1 do
  #    resources :categories, only: %i[index show] do
  #      resources :products, only: %i[index show]
  #    end
  #  end
  # end
  get 'up' => 'rails/health#show', as: :rails_health_check

  root to: redirect('/graphiql')
end
