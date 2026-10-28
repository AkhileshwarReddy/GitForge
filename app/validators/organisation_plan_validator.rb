class OrganisationPlanValidator < ActiveModel::Validator
    def validate(record)
        if record.plan_free?
            if record.storage_limit_bytes.to_i > 10.gigabytes
                record.errors.add(:storage_limit_bytes, "cannot exceed 10 GB on the Free plan")
            end

            if record.trial_ends_at.present?
                record.errors.add(:trial_ends_at, "is not applicable to the Free plan")
            end
        end
    end
end
