# frozen_string_literal: true

module Users
  class Delete < BaseInteractor
    delegate :user, to: :context

    def call
      user.destroy!
      context.message = 'Your account has successfully been deleted'
    rescue ActiveRecord::RecordNotDestroyed => e
      context.fail! errors: e.message
    end
  end
end
