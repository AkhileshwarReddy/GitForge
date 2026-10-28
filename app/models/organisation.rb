class Organisation < ApplicationRecord
    def plan_upgrade_summary
        return nil unless saved_change_to_plan?
        from_plan, to_plan = saved_change_to_plan
        "Plan changed from #{from_plan} to #{to_plan}"
    end

    def revert_unsaved_slug!
        restore_attribute!(:slug) if will_save_change_to_slug?
    end
end