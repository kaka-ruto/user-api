# frozen_string_literal: true

RSpec.describe Mutations::Users::Delete, type: :request do
  subject(:execute) do
    post graphql_path, params: { query: query_string, variables: variables }
  end

  let(:user) { create(:user) }

  describe '.resolve' do
    let(:variables) { { userId: user.id } }

    context 'when successful' do
      it 'deletes the user' do
        execute

        json = JSON.parse(response.body)
        data = json.dig('data', 'deleteUser')

        expect(data['message']).to eq 'Your account has successfully been deleted'
        expect(data['errors']).to be_nil
      end
    end
  end

  def query_string
    <<~GRAPHQL
      mutation($userId: ID!) {
        deleteUser(input: { userId: $userId }) {
          message,
          errors
        }
      }
    GRAPHQL
  end
end
