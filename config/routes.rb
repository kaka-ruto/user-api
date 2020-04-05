# frozen_string_literal: true

Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'

  Rails.application.routes.draw do
    if Rails.env.development?
      mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
    end
  end
end
