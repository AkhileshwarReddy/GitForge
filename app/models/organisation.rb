class Organisation < ApplicationRecord
    attribute :slug, :normalized_slig

    enum :plan, { free: 0, pro: 1, enterprise: 2 },
        prefix: :plan, validate: true

    store_accessor :settings, :default_branch, :require_2fa

    validates :name, presence: true, length: { minimum: 2, maximum: 120 }
    validates :slug, presence: true, length: { in: 2..80 },
        uniqueness: { case_sensitive: false,
            conditions: -> { where(deleted_at: nil) },
            message: "is already taken by active organisation" },
        format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/,
            message: "must be lowercase alphanumeric with hyphens" }
    validates :storage_limit_bytes,
        numericality: { only_integer: true,
            greater_than_or_equal_to: 1.gigabyte,
            less_than_or_equal_to: 100.terabytes
        }
    validates :trial_ends_at, comparison: { greater_than: -> { Time.current } }, allow_nil: true

    def plan_upgrade_summary
        return nil unless saved_change_to_plan?
        from_plan, to_plan = saved_change_to_plan
        "Plan changed from #{from_plan} to #{to_plan}"
    end

    def revert_unsaved_slug!
        restore_attribute!(:slug) if will_save_change_to_slug?
    end
end
