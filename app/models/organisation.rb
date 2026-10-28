class Organisation < ApplicationRecord
    has_many :memberships, dependent: :destroy do
        def grant!(user, level: :developer)
            record = find_or_initialize_by(user: user)
            record.update!(access_level: level)
            record
        end

        def maintainers_and_owners
            where(access_level: [:maintainer, :owner])
        end
    end
    has_many :members, through: :memberships, source: :user
    has_many :projects, dependent: :destroy
    has_many :repository_configs, through: :projects
    has_many :pinned_projects, -> { where(pinned: true, archived: false).order(stars_count: :desc) },
        class_name: 'Project'
    has_many :owners, -> { where(memberships: { access_level: :owner }) },
        through: :memberships, source: :user

    before_validation :derive_slug_from_name, on: :create
    after_initialize :apply_default_settings, if: :new_record?
    before_create :set_default_pro_trial, if: :plan_pro?
    before_destroy :prevent_verified_enterprise_destruction, prepend: true
    around_save :measure_save_duration
    after_save AuditLoggerCallback.new
    after_commit :publish_outbox_event, on: [ :create, :update ]
    after_rollback :mark_transaction_aborted

    attr_reader :last_save_duration_ms

    cattr_accessor :published_events, default: []
    attr_accessor :transaction_aborted

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

    def silent_verify!
        AuditLog.suppress do
            update!(verified: true)
        end
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

    def set_default_pro_trial
        self.trial_ends_at ||= 14.days.from_now
    end

    def prevent_verified_enterprise_destruction
        if plan_enterprise? && verified?
            errors.add(:base, "cannot destroy a verified enterprise, archive it first")
            throw(:abort)
        end
    end

    def measure_save_duration
        t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        yield
        @last_save_duration_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0) * 1000.0).round(2)
    end

    def publish_outbox_event
        self.class.published_events << { org_id: id, slug: slug, plan: plan }
    end

    def mark_transaction_aborted
        @transaction_aborted = true
    end
end
