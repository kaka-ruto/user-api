# frozen_string_literal: true

module Users
  RSpec.describe Create, type: :interactor do
    subject(:context) { described_class.call(attributes: attributes) }
     
    describe '.call' do
      context 'when given valid attributes' do
        let(:attributes) { { email: 'hello@cba.com', password: 'V3ryG00D' } }
         
        it 'succeeds' do
          expect(context).to be_a_success
        end

        it 'returns the user' do
          expect(context.user).to be_a User
        end
      end
       
      context 'when given invalid attributes' do
        let(:attributes) { { email: 'hello@cba.com', password: '' } }
        let(:error_message) { ["Validation failed: Password can't be blank"] }
         
        it 'fails' do
          expect(context).to be_a_failure
        end

        it 'returns an error messsage' do
          expect(context.messages).to eq error_message
        end
      end
    end
  end
end
