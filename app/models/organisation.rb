class Organisation < ApplicationRecord
    before_validation :derive_slug_from_name, on: :create
    after_initialize :apply_default_settings, if: :new_record?

    validates_with OrganisationPlanValidator

    RESERVED_NAMES = %w[admin api root help explore settings login help oauth graphql].freeze
    FREE_EMAIL_DOMAINS = %w[gmail.com yahoo.com hotmail.com outlook.com].freeze

    attribute :slug, :normalized_slug

    enum :plan, { free: 0, pro: 1, enterprise: 2 },
        prefix: :plan, validate: true

    store_accessor :settings, :default_branch, :require_2fa, :ip_allowlist

    validates :name, presence: true, length: { minimum: 2, maximum: 120 }
    validates :slug, presence: true, length: { in: 2..80 },
        exclusion: { in: RESERVED_NAMES, message: "%{value} is reserved" },
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

    with_options if: :plan_enterprise? do
        validates :billing_email, presence: true
        validates :verified, inclusion: { in: [ true ], message: "must be verified for Enterprise plan" }
        validates :ip_allowlist, presence: { message: "must specify at least one CIDR block for Enterprise" }
    end

    validates :ip_allowlist, cidr_array: true

    validate :require_corporate_billing_email, on: :billing_checkout

    def validation_error_payload
        errors.group_by_attribute.transform_values.with_index do |msgs, idx|
            attr = errors.messages.keys[idx]
            { messages: msgs.map(&:message), codes: errors.details[attr].map { |d| d[:error] } }
        end
    end

    def plan_upgrade_summary
        return nil unless saved_change_to_plan?
        from_plan, to_plan = saved_change_to_plan
        "Plan changed from #{from_plan} to #{to_plan}"
    end

    def revert_unsaved_slug!
        restore_attribute!(:slug) if will_save_change_to_slug?
    end

    private

    def require_corporate_billing_email
        domain = billing_email.to_s.split("@").last&.downcase
        if domain.blank? || FREE_EMAIL_DOMAINS.include?(domain)
            errors.add(:billing_email, :corporate_domain_required, message: "must be a corporate domain for checkout")
        end
    end

    def apply_default_settings
        self.settings = { default_branch: "main", require_2fa: false }.merge(settings || {})
    end

    def derive_slug_from_name
        self.slug = name if slug.blank? && name.present?
    end
end
