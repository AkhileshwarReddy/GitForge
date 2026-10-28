class User < ApplicationRecord
    def self.lock_account!(email)
        user = find_by!(email: email)
        user.update!(locked_at: Time.current, failed_attempts: user.failed_attempts + 1)
        user.reload
    end
end
