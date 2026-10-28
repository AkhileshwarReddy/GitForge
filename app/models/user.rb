class User < ApplicationRecord
    normalizes :email, with: ->(email) { email.strip.downcase }
    normalizes :username, with: ->(u) { u.strip }

    enum :role, { member: 0, moderator: 1, instance_admin: 2 },
        suffix: true

    store_accessor :preferences, :theme, :timezone, :compact_view, prefix: :pref

    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, length: { in: 3..60 },
        format: { with: /\A[a-zA-Z0-9_.-]+\z/ }

    def self.lock_account!(email)
        user = find_by!(email: email)
        user.update!(locked_at: Time.current, failed_attempts: user.failed_attempts + 1)
        user.reload
    end
end
