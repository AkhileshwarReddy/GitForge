class TenantBootstrapService
    def self.call(org_name:, admin_email:, admin_username:, plan: :pro)
        org = Organisation.create!(
            name: org_name,
            slug: org_name,
            billing_email: admin_email,
            default_branch: "main",
            require_2fa: true
        )

        org.update!(plan: plan)
        admin = User.create!(
            email: admin_email,
            username: admin_username,
            name: admin_username.titleize,
            role: :instance_admin,
            pref_theme: "dark",
            pref_timezone: "UTC"
        )

        { org: org, admin: admin, plan_diff: org.saved_change_to_plan }
    end
end
