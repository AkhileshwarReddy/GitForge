class Organisation < ApplicationRecord
    attribute :slug, :normalized_slig

    enum :plan, { free: 0, pro: 1, enterprise: 2 },
        prefix: :plan, validate: true

    store_accessor :settings, :default_branch, :require_2fa

    def plan_upgrade_summary
        return nil unless saved_change_to_plan?
        from_plan, to_plan = saved_change_to_plan
        "Plan changed from #{from_plan} to #{to_plan}"
    end

    def revert_unsaved_slug!
        restore_attribute!(:slug) if will_save_change_to_slug?
    end
end
