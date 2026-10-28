class User < ApplicationRecord
    RESERVED_NAMES = %w[admin api root help explore settings login help oauth graphql].freeze
    THEMES = %w[light dark system].freeze

    before_update :reset_failed_attempt_on_update, if: -> {
        will_save_change_to_locked_at? & locked_at.nil?
    }

    after_find { @hydrated_at = Process.clock_gettime(Process::CLOCK_MONOTONIC) }
    attr_reader :hydrated_at
    
    normalizes :email, with: ->(email) { email.strip.downcase }
    normalizes :username, with: ->(u) { u.strip }

    enum :role, { member: 0, moderator: 1, instance_admin: 2 },
        suffix: true

    store_accessor :preferences, :theme, :timezone, :compact_view, prefix: :pref

    validates :role, presence: { strict: ArgumentError }

    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP },
        uniqueness: { case_sensitive: false }
    validates :username, presence: true, length: { in: 3..60 },
        exclusion: { in: RESERVED_NAMES, message: "%{value} is reserved" },
        format: { with: /\A[a-zA-Z0-9_.-]+\z/ },
        uniqueness: { case_sensitive: false }
    validates :failed_attempts, comparison: { greater_than_or_equal_to: 0 }
    validates :pref_theme, inclusion: { in: THEMES }, allow_nil: true
    validates :terms_accepted, acceptance: true, on: :registration

    def self.lock_account!(email)
        user = find_by!(email: email)
        user.update!(locked_at: Time.current, failed_attempts: user.failed_attempts + 1)
        user.reload
    end

    private

    def reset_failed_attempt_on_update
        self.failed_attempts = 0
    end
end
