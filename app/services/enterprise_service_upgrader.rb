class EnterpriseServiceUpgrader
    def self.upgrade!(organisation:, billing_email:, ip_allowlist:)
        organisation.assign_attributes(
            plan: :enterprise,
            verified: true,
            billing_email: billing_email,
            ip_allowlist: ip_allowlist
        )

        if organisation.valid? && organisation.valid?(:billing_checkout)
            organisation.save!
            { success: true, organisation: organisation }
        else
            organisation.restore_attributes
            { success: false, errors: organisation.validation_error_payload }
        end
    end
end
