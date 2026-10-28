class OrganisationLifecycleManager 
    def self.run_demo!(org_name)
        org = Organisation.create!(name: org_name, plan: :pro)
        org.update!(
            plan: :enterprise,
            verified: true,
            billing_email: "ops@#{org.slug}.com",
            ip_allowlist: ["0.0.0.0"]
        )

        org_destroyed = begin
            org.destroy!
            true
        rescue ActiveRecord::RecordNotDestroyed
            false
        end

        audits = AuditLog.where(auditable_type: "Organisation", auditable_id: org.id).order(:id)
        {
            org: org,
            destroy_blocked: !org_destroyed,
            audit_count: audits.count,
            events: Organisation.published_events.last(2)
        }
    end
end