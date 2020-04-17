# frozen_string_literal: true

RSpec.describe Mutations::Users::Update, type: :request do
  subject(:execute) do
    post graphql_path, params: { query: query_string, variables: variables }
  end

  let(:user) { create(:user) }

  describe '.resolve' do
    context 'when valid params' do
      let(:variables) { { userId: user.id, email: 'arianna@email.com' } }
       
      it 'updates the user' do
        execute

        json = JSON.parse(response.body)
        data = json.dig('data', 'updateUser')

        expect(data['errors']).to be_nil
        expect(data['user']).to include({ "email" => "arianna@email.com" })
      end
    end

    context 'when invalid params' do
      let(:variables) { { userId: user.id, email: '' } }

      it 'returns an errror message' do
        execute

        json = JSON.parse(response.body)
        data = json.dig('data', 'updateUser')

        expect(data['user']).to be_nil
        expect(data['errors']).to eq ["Email is invalid", "Email can't be blank"]
      end
    end
  end

  def query_string
    <<~GRAPHQL
      mutation($userId: ID!, $email: String!) {
        updateUser(input: { userId: $userId, email: $email }) {
          user {
            firstName
            email
          },
          errors
        }
      }
    GRAPHQL
  end
end
