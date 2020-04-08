# frozen_string_literal: true

RSpec.describe Mutations::Users::Create, type: :request do
  describe '.resolve' do
    context 'valid params' do
      it 'creates a new user' do
        expect {
          post graphql_path, params: { query: query_string, variables: variables }
        }.to change(User, :count).by 1
      end

      it 'returns the created user' do
        execute = post graphql_path, params: { query: query_string, variables: variables }

        json = JSON.parse(response.body)
        user = json.dig('data', 'createUser', 'user')

        expect(user).to include(
           {"fullName"=>"Marc Andre", "email"=>"marc.andre@witz.com"}
        )
      end
    end

    context 'when invalid params' do
      it 'returns an error message' do
        execute = post graphql_path, params: { query: query_string, variables: invalid_variables }

        json = JSON.parse(response.body)
        errors = json.dig('data', 'createUser', 'errors')

        expect(errors).to eq ["Validation failed: Email is invalid, Email can't be blank"]
      end
    end
  end

  def query_string
    <<~GRAPHQL
        mutation($firstName: String!, $lastName: String!, $email: String!, $password: String!) {
          createUser(input: {
            firstName: $firstName, lastName: $lastName, email: $email, password: $password
          }) {
            user { fullName email },
            errors
          }
        }
    GRAPHQL
  end

  def variables
    {
      firstName: 'Marc',
      lastName: 'Andre',
      email: 'marc.andre@witz.com',
      password: '$52435^26t389'
    }
  end
   
  def invalid_variables
    {
      firstName: 'Marc',
      lastName: 'Andre',
      email: '',
      password: '$52435^26t389'
    }
  end
end
