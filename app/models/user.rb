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

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i.freeze

  validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true, uniqueness: true
end
