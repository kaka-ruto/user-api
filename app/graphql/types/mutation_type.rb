module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::Create
  end
end
