# frozen_string_literal: true

module Users
  RSpec.describe Update, type: :interactor do
    subject(:context) { described_class.call(user: user, attributes: attributes) }

    let(:user) { create(:user) }

    context 'when attributes are valid'do
      let(:attributes) { { first_name: 'Allan', last_name: 'Alpha' } }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'updates the first name' do
        expect { context; user.reload }.to change { user.first_name }.to attributes[:first_name]
      end

      it 'returns the user object' do
        expect(context.user).to be_a User
      end
    end
     
    context 'when attributes are invalid'do
      let(:attributes) { { email: '@email.com' } }

      it 'succeeds' do
        expect(context).to be_a_failure
      end

      it 'returns an error message' do
        expect(context.messages).to eq ["Email is invalid"]
      end
    end
  end
end
