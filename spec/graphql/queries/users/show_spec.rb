# frozen_string_literal: true

RSpec.describe Queries::Users::Show do
  describe '.resolve' do
    it 'returns the user' do
      user = create(:user)
      variables = { id: user.id }

      result_hash = UserApiSchema.execute(query_string, variables: variables)

      expect(result_hash.dig('data', 'showUser')).to include(
        'email' => user.email, 'fullName' => "#{user.first_name} " + "#{user.last_name}"
      )
    end
  end

  def query_string
    <<~GRAPHQL
      query($id: ID!) {
        showUser(id: $id) {
          email
          fullName
        }
      }
    GRAPHQL
  end
end
