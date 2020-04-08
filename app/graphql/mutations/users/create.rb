# frozen_string_literal: true

class Mutations::Users::Create < Mutations::BaseMutation
  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :email, String, required: true
  argument :password, String, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: true

  def resolve(**args)
    result = ::Users::Create.call(attributes: args)

    if result.success?
      { user: result.user }
    else
      { errors: result.messages }
    end
  end
end
