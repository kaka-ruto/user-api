module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::Create
    field :update_user, mutation: Mutations::Users::Update
    field :delete_user, mutation: Mutations::Users::Delete
  end
end
