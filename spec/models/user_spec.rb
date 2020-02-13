# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           default(""), not null
#  first_name :string
#  last_name  :string
#  password   :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }

  context 'when email is valid' do
    it 'successfully creates the user' do
      user = build(:user, email: 'example@email.com')

      result = user.save

      expect(result).to be_truthy
    end
  end

  context 'when email is invalid' do
    it 'does not create the user' do
      user = build(:user, email: 'email.com')

      result = user.save

      expect(result).to be_falsy
    end
  end
end
