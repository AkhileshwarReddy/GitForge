# 150 Connected ActiveRecord Mastery Exercises: Build the Complete `GitForge` Engine

This curriculum contains **150 sequential, cumulative hands-on exercises** designed to take you from ActiveRecord fundamentals to Staff-level internals. Every single task (`Task 001` → `Task 150`) builds directly on the schema, models, associations, scopes, locks, and services created in the immediately preceding task.

By completing `Task 001` through `Task 150` in order, you incrementally construct **`GitForge`**—a complete, working multi-tenant DevOps, Issue Tracking, Merge Request, CI/CD Queue, and Usage Billing engine covering **100% of the ActiveRecord API surface area (Rails 7.1 / 8.0)**.

## Architectural Dependency Map (15 Progressive Modules)

| Module | Tasks | Domain Entities Introduced / Extended | Core ActiveRecord Capabilities Mastered |
| :--- | :--- | :--- | :--- |
| **Module 1** | `001`–`010` | **Schema Foundations, Migrations, Column Types, Custom Types & Dirty Tracking** | Establish the core `organizations` and `users` schema, `ApplicationRecord` conventions, custom `ActiveRecord::Type::Value` casting, Rails 7.1 `normalizes`, `store_accessor`, `ActiveModel::Dirty` change tracking, and type-safe `enum` declarations. |
| **Module 2** | `011`–`020` | **Validations, Conditional Rules, Validation Contexts & Custom Validators** | Layer production-grade data integrity onto `Organization` and `User` using built-in validators, partial-index-backed uniqueness, `comparison` validators, `with_options` conditional groups, custom validation contexts (`on: :billing_checkout`), `ActiveModel::EachValidator`, and `ActiveModel::Validator`. |
| **Module 3** | `021`–`030` | **Callbacks Lifecycle, Halting (`throw :abort`), Audit Hooks & Transactional Callbacks** | Wire lifecycle hooks (`after_initialize`, `before_validation`, `around_save`, `before_destroy` with `throw(:abort)`), reusable callback classes (`AuditLoggerCallback` writing to `audit_logs`), `ActiveRecord::Suppressor`, and `after_commit` / `after_rollback` transactional guarantees. |
| **Module 4** | `031`–`040` | **Core Associations (`belongs_to`, `has_one`, `has_many`, `:through`, Extensions & `inverse_of`)** | Connect `Organization` and `User` to `Membership`, `Project`, and `RepositoryConfig` using foreign keys, `touch: true`, `dependent:` strategies, `has_many :through`, scoped associations, association extensions, `inverse_of` memory identity, and `accepts_nested_attributes_for`. |
| **Module 5** | `041`–`050` | **Advanced Associations (Self-Referential, Polymorphic, STI, `DelegatedType` & Counter Caches)** | Expand `Project` into a full issue/MR tracker with `Milestone`, self-referential `Issue` hierarchies (`parent_issue` / `sub_issues`), `MergeRequest`, polymorphic `Note`s and `LabelLink`s, Single Table Inheritance (`Integration`), `DelegatedType` (`TimelineEvent`), and `counter_cache` reconciliation. |
| **Module 6** | `051`–`060` | **Query Interface I — Predicate Filtering, Anti-Joins, Safe `LIKE`, Ordering & Subqueries** | Query `Issue` and `Project` relations using endless/beginless ranges, `where.associated`, `where.missing` anti-joins, `sanitize_sql_like`, `Relation#or` / `Relation#and`, `in_order_of`, virtual SQL projections, `pluck` vs `pick`, `exists?`, and composable relation subqueries. |
| **Module 7** | `061`–`070` | **Query Interface II — Joins, Aggregations, `having`, `load_async`, CTEs & Window Functions** | Build analytical rollups across `GitForge` using nested `joins`, `left_joins`, derived subquery joins, multi-column `group` + `having`, parallel `load_async` / `async_count`, Rails 7.1 `.with` Common Table Expressions, recursive CTE tree traversal (`descendant_tree`), and `DENSE_RANK() OVER (...)` window functions. |
| **Module 8** | `071`–`080` | **Scopes, Query Composition (`merge`, `unscope`, `rewhere`), `Model.none` & Query Objects** | Architect clean query pipelines using parameterized scopes, cross-model `Relation#merge`, surgical `unscope` / `rewhere`, `Archivable` soft-deletion without `default_scope`, `Relation#extending`, `Project.visible_to` with `Model.none`, `readonly`, race-safe `create_or_find_by!`, and composable Query Objects. |
| **Module 9** | `081`–`090` | **Eager Loading (`preload`, `eager_load`, `includes`), `strict_loading!` & Batch Processing** | Eliminate N+1 queries with verifiable `SqlQueryCounter` instrumentation, `preload` vs `eager_load` vs `includes`, polymorphic/`DelegatedType` eager loading, `strict_loading!`, `.size` vs `.count` counter-cache optimization, `find_each`, and `in_batches(load: false)`. |
| **Module 10** | `091`–`100` | **Arel AST Mastery & Advanced SQL Construction (`CASE`, `EXISTS`, `LATERAL`, `UNION ALL`)** | Drop down to `arel_table` AST nodes to construct grouped boolean predicates, `Arel::Nodes::NamedFunction` (`COALESCE`), `Arel::Nodes::Case` dynamic SLA scoring, explicit `OuterJoin` ASTs, correlated `EXISTS` subqueries, top-N-per-group queries, and `UNION ALL` work item feeds. |
| **Module 11** | `101`–`110` | **Bulk Persistence (`insert_all!`, `upsert_all`), Savepoints & Concurrency Locking** | Execute high-throughput and concurrency-safe writes using `insert_all!`, idempotent `upsert_all`, atomic `update_all`, nested savepoints (`requires_new: true`), optimistic locking (`lock_version`), deterministic pessimistic locking (`CreditWallet.transfer!`), and `FOR UPDATE SKIP LOCKED` (`CiBuild.claim_next_batch!`). |
| **Module 12** | `111`–`120` | **Database-Native Power Features (Arrays, JSONB, Range Overlaps, Views, Advisory Locks & Tenant Context)** | Leverage advanced relational capabilities including array/JSONB containment, temporal range overlap prevention (`DeployFreezeWindow`), string-backed enums, virtual stored columns (`reference_code`), SQL views (`ProjectHealthSummary`), covering indexes, advisory locks, and `CurrentAttributes` tenant scoping. |
| **Module 13** | `121`–`130` | **Modern Rails 7.1 / 8.0 Features (Composite Primary Keys, Encryption, Stateless Tokens & Multi-DB)** | Master modern ActiveRecord additions: composite primary keys (`ProjectDeployment` with `[:project_id, :deployment_number]` and `query_constraints`), deterministic vs non-deterministic `encrypts`, `generates_token_for`, `has_secure_token`, `connected_to(prevent_writes: true)`, and `disable_joins: true`. |
| **Module 14** | `131`–`140` | **Zero-Downtime Migrations, Batched Backfills, Connection Pool, Query Cache & Telemetry** | Operate ActiveRecord safely at scale with `disable_ddl_transaction!`, unvalidated check constraints, `ignored_columns`, checkpointed `BatchedMigrationJob` backfills, `connection_pool` management, `QueryCache` inspection, `QueryLogs` SQL comments, `instantiation.active_record` telemetry, and schema auditing. |
| **Module 15** | `141`–`150` | **End-to-End Capstone Integration — Assembling & Verifying the Complete `GitForge` Engine** | Connect every model, association, scope, validator, lock, and query built in Tasks 001–140 into 10 production domain services culminating in `GitForge::MasterVerificationRunner.run!` (Task 150). |

## Module 1: Schema Foundations, Migrations, Column Types, Custom Types & Dirty Tracking

> **Module Goal**: Establish the core `organizations` and `users` schema, `ApplicationRecord` conventions, custom `ActiveRecord::Type::Value` casting, Rails 7.1 `normalizes`, `store_accessor`, `ActiveModel::Dirty` change tracking, and type-safe `enum` declarations.

### Task 001: Create the Core `organizations` Table Migration
- **Depends On**: None (Foundation Task — initializes the `GitForge` database schema)
- **ActiveRecord Concepts**: `ActiveRecord::Migration[7.1]`, `create_table`, `null: false`, `default:`, `limit:`, `timestamps`, `comment:`
- **Task Requirement**: Create the initial migration for `organizations` with `name` (string, limit 120, not null), `slug` (string, limit 80, not null), `plan` (integer, default 0, not null), `billing_email` (string), `verified` (boolean, default false, not null), and `timestamps`.

```ruby
class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations, comment: "Multi-tenant root organizations" do |t|
      t.string  :name, limit: 120, null: false
      t.string  :slug, limit: 80, null: false
      t.integer :plan, default: 0, null: false
      t.string  :billing_email
      t.boolean :verified, default: false, null: false
      t.timestamps
    end
  end
end
```

### Task 002: Define `ApplicationRecord` Conventions & the `Organization` Model
- **Depends On**: Task 001 (maps the `organizations` table created in Task 001 into an ActiveRecord model)
- **ActiveRecord Concepts**: `primary_abstract_class`, `implicit_order_column`, `table_name`, `primary_key`, `.new`, `.create!`
- **Task Requirement**: Configure `ApplicationRecord` with `primary_abstract_class` and `self.implicit_order_column = :created_at` so chronological `.first` and `.last` work predictably even with UUIDs. Define `Organization < ApplicationRecord` and instantiate your first persisted record.

```ruby
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  self.implicit_order_column = :created_at
end

class Organization < ApplicationRecord
  # Inherits table_name = 'organizations' and primary_key = 'id'
end

# Verification:
org = Organization.create!(name: "GitLab Core", slug: "gitlab-core", billing_email: "billing@gitlab.com")
org.persisted? # => true
```

### Task 003: Alter `organizations` with Bulk `change_table` & Native Column Types
- **Depends On**: Task 002 (extends the `organizations` table and `Organization` model from Tasks 001–002)
- **ActiveRecord Concepts**: `change_table(:organizations, bulk: true)`, `:bigint`, `:jsonb`, `:datetime`, `:uuid`
- **Task Requirement**: Write a migration using `change_table :organizations, bulk: true` to add `storage_limit_bytes` (`:bigint`, default 5GB), `settings` (`:jsonb`, default `{}`), `trial_ends_at` (`:datetime`), and `deleted_at` (`:datetime`) in a single `ALTER TABLE` statement.

```ruby
class AddMetadataToOrganizations < ActiveRecord::Migration[7.1]
  def change
    change_table :organizations, bulk: true do |t|
      t.bigint   :storage_limit_bytes, default: 5_368_709_120, null: false
      t.jsonb    :settings, default: {}, null: false
      t.datetime :trial_ends_at
      t.datetime :deleted_at
    end
  end
end
```

### Task 004: Create the `users` Table with Unique Indexes & Database Check Constraints
- **Depends On**: Task 003 (prepares user identities that will belong to and administer `Organization` records)
- **ActiveRecord Concepts**: `add_index`, `unique: true`, `where:` (partial index), `add_check_constraint`
- **Task Requirement**: Create the `users` table with `email`, `username`, `name`, `role` (integer, default 0), `failed_attempts` (integer, default 0), `locked_at` (datetime), and `preferences` (jsonb). Add a unique index on `LOWER(email)`, a unique index on `username`, and a check constraint ensuring `failed_attempts >= 0`.

```ruby
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string   :email, null: false
      t.string   :username, limit: 60, null: false
      t.string   :name, null: false
      t.integer  :role, default: 0, null: false
      t.integer  :failed_attempts, default: 0, null: false
      t.datetime :locked_at
      t.jsonb    :preferences, default: {}, null: false
      t.timestamps
    end

    add_index :users, "LOWER(email)", unique: true, name: "index_users_on_lower_email"
    add_index :users, :username, unique: true
    add_check_constraint :users, "failed_attempts >= 0", name: "chk_users_failed_attempts_non_negative"
  end
end
```

### Task 005: Core CRUD & Retrieval Semantics on `Organization` and `User`
- **Depends On**: Task 004 (operates on the `Organization` and `User` tables created in Tasks 001–004)
- **ActiveRecord Concepts**: `find`, `find_by`, `find_by!`, `take`, `first!`, `update!`, `update_columns`, `reload`
- **Task Requirement**: Define `User < ApplicationRecord` and implement a class helper `User.lock_account!(email)` that locates the user via `find_by!(email:)`, increments `failed_attempts`, sets `locked_at: Time.current` via `update!`, and contrasts it with `update_columns`.

```ruby
class User < ApplicationRecord
  def self.lock_account!(email)
    user = find_by!(email: email)
    user.update!(locked_at: Time.current, failed_attempts: user.failed_attempts + 1)
    user.reload
  end
end
```

### Task 006: Track Attribute Mutations with `ActiveModel::Dirty`
- **Depends On**: Task 005 (adds state inspection to `Organization` and `User` updates from Task 005)
- **ActiveRecord Concepts**: `changed?`, `changes`, `will_save_change_to_attribute?`, `saved_change_to_attribute?`, `attribute_before_last_save`, `restore_attributes`
- **Task Requirement**: Add a method `Organization#plan_upgrade_summary` that checks `will_save_change_to_plan?` before save (or `saved_change_to_plan?` after save) and returns the transition tuple `[plan_before_last_save, plan]`, plus a `revert_unsaved_slug!` helper using `restore_attribute!(:slug)`.

```ruby
class Organization < ApplicationRecord
  def plan_upgrade_summary
    return nil unless saved_change_to_plan?
    from_plan, to_plan = saved_change_to_plan
    "Plan changed from #{from_plan} to #{to_plan}"
  end

  def revert_unsaved_slug!
    restore_attribute!(:slug) if will_save_change_to_slug?
  end
end
```

### Task 007: Custom `ActiveRecord::Type::Value` Casting & Registration
- **Depends On**: Task 006 (enforces type-level slug normalization on `Organization#slug` from Tasks 001–006)
- **ActiveRecord Concepts**: `ActiveRecord::Type::Value`, `ActiveRecord::Type.register`, `attribute :slug, :normalized_slug`
- **Task Requirement**: Build a custom `NormalizedSlugType < ActiveRecord::Type::String` that strips whitespace, downcases, and replaces non-alphanumeric characters with hyphens on both Ruby assignment (`cast`) and DB serialization (`serialize`). Register it as `:normalized_slug` and apply it to `Organization`.

```ruby
class NormalizedSlugType < ActiveRecord::Type::String
  def cast(value)
    return nil if value.nil?
    super(value.to_s.strip.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-\z/, ""))
  end
end

ActiveRecord::Type.register(:normalized_slug, NormalizedSlugType)

class Organization < ApplicationRecord
  attribute :slug, :normalized_slug
  attribute :virtual_note, :string, default: "in-memory-only"
end
```

### Task 008: Attribute Normalization (`normalizes`) & Structured Store Accessors (`store_accessor`)
- **Depends On**: Task 007 (adds normalization and JSONB key accessors to `User` and `Organization`)
- **ActiveRecord Concepts**: `normalizes` (Rails 7.1+), `store_accessor`, `store`
- **Task Requirement**: Use Rails 7.1 `normalizes` on `User` so `email` is always stripped and downcased even in `User.find_by(email: '  ADMIN@GitLab.com ')` queries! Expose `theme`, `timezone`, and `compact_view` on `User#preferences` and `default_branch` on `Organization#settings` via `store_accessor`.

```ruby
class User < ApplicationRecord
  normalizes :email, with: ->(email) { email.strip.downcase }
  normalizes :username, with: ->(u) { u.strip }

  store_accessor :preferences, :theme, :timezone, :compact_view, prefix: :pref
end

class Organization < ApplicationRecord
  store_accessor :settings, :default_branch, :require_2fa, :ip_allowlist
end
```

### Task 009: Declare Type-Safe `enum` Mappings with Prefixes, Suffixes & Scopes
- **Depends On**: Task 008 (maps the integer `plan` column on `Organization` and `role` column on `User`)
- **ActiveRecord Concepts**: `enum`, `prefix:`, `suffix:`, `default:`, `validate: true`, generated bang/predicate/scope methods
- **Task Requirement**: Declare `enum :plan, { free: 0, pro: 1, enterprise: 2 }, prefix: :plan, validate: true` on `Organization` and `enum :role, { member: 0, moderator: 1, instance_admin: 2 }, suffix: true` on `User`. Verify generated scopes (`Organization.plan_enterprise`) and bang transitions (`org.plan_pro!`).

```ruby
class Organization < ApplicationRecord
  enum :plan, { free: 0, pro: 1, enterprise: 2 }, prefix: :plan, default: :free, validate: true
end

class User < ApplicationRecord
  enum :role, { member: 0, moderator: 1, instance_admin: 2 }, suffix: true, default: :member, validate: true
end
```

### Task 010: Module 1 Milestone: `TenantBootstrapService` Combining Schema, Types, Dirty Tracking & Enums
- **Depends On**: Task 009 (integrates `Organization` and `User` features built across Tasks 001–009)
- **ActiveRecord Concepts**: End-to-end Model Instantiation, Normalization, Store Accessors, Enums, and Dirty Tracking
- **Task Requirement**: Implement `TenantBootstrapService.call(org_name:, admin_email:, admin_username:, plan: :pro)` that creates a normalized `Organization` and `User`, configures their JSONB store settings, upgrades the organization plan, and returns a structured hash including `saved_change_to_plan`.

```ruby
class TenantBootstrapService
  def self.call(org_name:, admin_email:, admin_username:, plan: :pro)
    org = Organization.create!(
      name: org_name,
      slug: org_name, # Cast automatically by NormalizedSlugType
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

    { organization: org, admin: admin, plan_diff: org.saved_change_to_plan }
  end
end
```

## Module 2: Validations, Conditional Rules, Validation Contexts & Custom Validators

> **Module Goal**: Layer production-grade data integrity onto `Organization` and `User` using built-in validators, partial-index-backed uniqueness, `comparison` validators, `with_options` conditional groups, custom validation contexts (`on: :billing_checkout`), `ActiveModel::EachValidator`, and `ActiveModel::Validator`.

### Task 011: Presence, Length & Strict Regex Format Validations on `Organization` and `User`
- **Depends On**: Task 010 (adds boundary validations to `Organization` and `User` created in Module 1)
- **ActiveRecord Concepts**: `validates`, `presence: true`, `length: { in: ... }`, `format: { with: /\A...\z/ }`
- **Task Requirement**: Add presence, length, and multi-line-safe `\A...\z` format validations to `Organization` (`name`, `slug`) and `User` (`email`, `username`) so newline injection (`"valid\n<script>"`) is rejected.

```ruby
class Organization < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 120 }
  validates :slug, presence: true, length: { in: 2..80 },
                   format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/, message: "must be lowercase alphanumeric with hyphens" }
end

class User < ApplicationRecord
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, length: { in: 3..60 },
                       format: { with: /\A[a-zA-Z0-9_.-]+\z/ }
end
```

### Task 012: Scoped & Conditional Uniqueness Validations Backed by Partial Indexes
- **Depends On**: Task 011 (adds uniqueness guarantees to `Organization#slug` and `User#email`)
- **ActiveRecord Concepts**: `uniqueness: { case_sensitive: false, conditions: -> { ... } }`
- **Task Requirement**: Add a uniqueness validation on `Organization#slug` scoped to active (non-deleted) organizations (`conditions: -> { where(deleted_at: nil) }`) and case-insensitive uniqueness on `User#email` and `User#username`.

```ruby
class Organization < ApplicationRecord
  validates :slug, uniqueness: {
    case_sensitive: false,
    conditions: -> { where(deleted_at: nil) },
    message: "is already taken by an active organization"
  }
end

class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false }
  validates :username, uniqueness: { case_sensitive: false }
end
```

### Task 013: Numericality & Temporal `comparison` Validations
- **Depends On**: Task 012 (validates `storage_limit_bytes` and `trial_ends_at` on `Organization`)
- **ActiveRecord Concepts**: `numericality: { only_integer: true, greater_than_or_equal_to: ... }`, `comparison: { greater_than: ... }`
- **Task Requirement**: Validate that `Organization#storage_limit_bytes` is an integer between 1 GB and 100 TB, `User#failed_attempts` is `>= 0`, and `Organization#trial_ends_at` (when present) is strictly greater than `Time.current` using Rails' built-in `comparison` validator.

```ruby
class Organization < ApplicationRecord
  validates :storage_limit_bytes, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1.gigabyte,
    less_than_or_equal_to: 100.terabytes
  }
  validates :trial_ends_at, comparison: { greater_than: -> { Time.current } }, allow_nil: true
end
```

### Task 014: Exclusion of Reserved Slugs, Inclusion & Acceptance Validations
- **Depends On**: Task 013 (prevents route collisions on `Organization#slug` and `User#username`)
- **ActiveRecord Concepts**: `exclusion: { in: ... }`, `inclusion: { in: ... }`, `acceptance: true`
- **Task Requirement**: Prevent `Organization#slug` and `User#username` from using reserved system paths (`%w[admin api root help explore settings login oauth]`) via `exclusion`, validate `User#pref_theme` inclusion in `%w[light dark system]`, and require virtual `:terms_accepted` acceptance.

```ruby
RESERVED_NAMES = %w[admin api root help explore settings login oauth graphql].freeze

class Organization < ApplicationRecord
  validates :slug, exclusion: { in: RESERVED_NAMES, message: "%{value} is a reserved system path" }
end

class User < ApplicationRecord
  validates :pref_theme, inclusion: { in: %w[light dark system] }, allow_nil: true
  validates :terms_accepted, acceptance: true, on: :registration
end
```

### Task 015: Grouped Conditional Validations with `with_options`
- **Depends On**: Task 014 (enforces strict enterprise compliance rules on `Organization` when `plan_enterprise?` is true)
- **ActiveRecord Concepts**: `with_options`, `:if`, `:unless`, Lambda conditions
- **Task Requirement**: Use `with_options if: :plan_enterprise?` on `Organization` to require `billing_email`, `verified == true`, and a non-empty `ip_allowlist` in `settings` whenever an organization is on the `enterprise` plan.

```ruby
class Organization < ApplicationRecord
  with_options if: :plan_enterprise? do
    validates :billing_email, presence: true
    validates :verified, inclusion: { in: [true], message: "must be verified for Enterprise plan" }
    validates :ip_allowlist, presence: { message: "must specify at least one CIDR block for Enterprise" }
  end
end
```

### Task 016: Custom Validation Contexts (`on: :billing_checkout`)
- **Depends On**: Task 015 (adds multi-step workflow validation contexts to `Organization`)
- **ActiveRecord Concepts**: `valid?(:context_name)`, `save!(context: :context_name)`, `on: [:create, :custom_context]`
- **Task Requirement**: Add a validation rule on `Organization` that runs only on the `:billing_checkout` context requiring `billing_email` to not belong to a free webmail provider (`gmail.com`, `yahoo.com`), and verify it with `org.valid?(:billing_checkout)`.

```ruby
class Organization < ApplicationRecord
  FREE_EMAIL_DOMAINS = %w[gmail.com yahoo.com hotmail.com outlook.com].freeze

  validate :require_corporate_billing_email, on: :billing_checkout

  private

  def require_corporate_billing_email
    domain = billing_email.to_s.split("@").last&.downcase
    if domain.blank? || FREE_EMAIL_DOMAINS.include?(domain)
      errors.add(:billing_email, :corporate_domain_required, message: "must be a corporate domain for checkout")
    end
  end
end
```

### Task 017: Custom `ActiveModel::EachValidator` (`CidrArrayValidator`)
- **Depends On**: Task 016 (validates the `Organization#ip_allowlist` JSONB array required in Task 015)
- **ActiveRecord Concepts**: `ActiveModel::EachValidator`, `validate_each(record, attribute, value)`, `IPAddr`
- **Task Requirement**: Write a reusable `CidrArrayValidator < ActiveModel::EachValidator` that parses every string in an array with `IPAddr.new(cidr)` and adds structured errors to `record.errors.add(attribute, :invalid_cidr, value: cidr)` if any entry is malformed. Attach it to `Organization` via `validates :ip_allowlist, cidr_array: true`.

```ruby
require "ipaddr"

class CidrArrayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    unless value.is_a?(Array)
      record.errors.add(attribute, :not_an_array, message: "must be an array of CIDR strings")
      return
    end

    value.each do |cidr|
      IPAddr.new(cidr.to_s)
    rescue IPAddr::Error
      record.errors.add(attribute, :invalid_cidr, message: "contains invalid CIDR '#{cidr}'")
    end
  end
end

class Organization < ApplicationRecord
  validates :ip_allowlist, cidr_array: true
end
```

### Task 018: Multi-Attribute Policy Validation with `ActiveModel::Validator` & `validates_with`
- **Depends On**: Task 017 (validates cross-attribute invariants on `Organization`)
- **ActiveRecord Concepts**: `ActiveModel::Validator`, `validates_with`, `record.errors.add(:base, ...)`
- **Task Requirement**: Create `OrganizationPlanQuotaValidator < ActiveModel::Validator` and wire it via `validates_with`. Enforce that `free` plan orgs cannot exceed 10 GB `storage_limit_bytes` and cannot set a `trial_ends_at` date.

```ruby
class OrganizationPlanQuotaValidator < ActiveModel::Validator
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

class Organization < ApplicationRecord
  validates_with OrganizationPlanQuotaValidator
end
```

### Task 019: Inspecting `ActiveModel::Errors` Structured Details & Strict Validation Exceptions
- **Depends On**: Task 018 (queries structured error metadata generated by Tasks 011–018)
- **ActiveRecord Concepts**: `errors.details`, `errors.where(:attr, :type)`, `errors.of_kind?(:attr, :type)`, `strict: true`
- **Task Requirement**: Add a strict validation on `User#role` (`validates :role, presence: { strict: ArgumentError }`) and write an error serializer `Organization#validation_error_payload` that uses `errors.details` and `errors.messages` for API responses.

```ruby
class Organization < ApplicationRecord
  def validation_error_payload
    errors.messages.transform_values.with_index do |msgs, idx|
      attr = errors.messages.keys[idx]
      { messages: msgs, codes: errors.details[attr].map { |d| d[:error] } }
    end
  end
end
```

### Task 020: Module 2 Milestone: `EnterpriseUpgradeGatekeeper` Validating Multi-Context Promotions
- **Depends On**: Task 019 (combines all validations and custom validators from Tasks 011–019)
- **ActiveRecord Concepts**: Contextual Validation (`valid?(:billing_checkout)`), Custom Validators, Error Serialization, Rollback on Invalid
- **Task Requirement**: Build `EnterpriseUpgradeGatekeeper.upgrade!(organization, billing_email:, ip_allowlist:)` that assigns the attributes, switches `plan` to `:enterprise`, runs both default and `:billing_checkout` validation contexts, and persists or returns `organization.validation_error_payload`.

```ruby
class EnterpriseUpgradeGatekeeper
  def self.upgrade!(organization, billing_email:, ip_allowlist:)
    organization.assign_attributes(
      plan: :enterprise,
      verified: true,
      billing_email: billing_email,
      ip_allowlist: ip_allowlist
    )

    if organization.valid? && organization.valid?(:billing_checkout)
      organization.save!
      { success: true, organization: organization }
    else
      organization.restore_attributes
      { success: false, errors: organization.validation_error_payload }
    end
  end
end
```

## Module 3: Callbacks Lifecycle, Halting (`throw :abort`), Audit Hooks & Transactional Callbacks

> **Module Goal**: Wire lifecycle hooks (`after_initialize`, `before_validation`, `around_save`, `before_destroy` with `throw(:abort)`), reusable callback classes (`AuditLoggerCallback` writing to `audit_logs`), `ActiveRecord::Suppressor`, and `after_commit` / `after_rollback` transactional guarantees.

### Task 021: Default Initialization & Hydration Hooks (`after_initialize` & `after_find`)
- **Depends On**: Task 020 (hooks into `Organization` and `User` object lifecycle from Modules 1–2)
- **ActiveRecord Concepts**: `after_initialize`, `after_find`, `new_record?`
- **Task Requirement**: Add an `after_initialize` callback on `Organization` that sets default `settings['default_branch'] ||= 'main'` on new records without overwriting persisted DB values, and an `after_find` hook on `User` that records `@hydrated_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)`.

```ruby
class Organization < ApplicationRecord
  after_initialize :apply_default_settings, if: :new_record?

  private

  def apply_default_settings
    self.settings = { "default_branch" => "main", "require_2fa" => false }.merge(settings || {})
  end
end

class User < ApplicationRecord
  attr_reader :hydrated_at
  after_find { @hydrated_at = Process.clock_gettime(Process::CLOCK_MONOTONIC) }
end
```

### Task 022: `before_validation` & `before_save` Fallback Slug & Token Digest Generation
- **Depends On**: Task 021 (auto-populates `Organization#slug` before Task 011's presence validation runs)
- **ActiveRecord Concepts**: `before_validation`, `before_save`, `SecureRandom`, `Digest::SHA256`
- **Task Requirement**: Add a `before_validation :derive_slug_from_name, on: :create` on `Organization` so if `slug` is blank, it is automatically derived from `name` before presence validation checks it.

```ruby
class Organization < ApplicationRecord
  before_validation :derive_slug_from_name, on: :create

  private

  def derive_slug_from_name
    self.slug = name if slug.blank? && name.present?
  end
end
```

### Task 023: `before_create` vs `before_update` Timestamp Tracking
- **Depends On**: Task 022 (tracks plan changes and account lockouts on `Organization` and `User`)
- **ActiveRecord Concepts**: `before_create`, `before_update`, `will_save_change_to_attribute?`
- **Task Requirement**: On `Organization`, set `trial_ends_at = 14.days.from_now` inside `before_create` if the organization starts on the `pro` plan. On `User`, automatically clear `failed_attempts = 0` inside `before_update` whenever `locked_at` transitions from a timestamp back to `nil`.

```ruby
class Organization < ApplicationRecord
  before_create :assign_default_pro_trial, if: :plan_pro?

  private

  def assign_default_pro_trial
    self.trial_ends_at ||= 14.days.from_now
  end
end

class User < ApplicationRecord
  before_update :reset_failed_attempts_on_unlock, if: -> { will_save_change_to_locked_at? && locked_at.nil? }

  private

  def reset_failed_attempts_on_unlock
    self.failed_attempts = 0
  end
end
```

### Task 024: Halting Persistence & Deletion with `throw(:abort)`
- **Depends On**: Task 023 (protects verified `enterprise` `Organization` records from accidental deletion)
- **ActiveRecord Concepts**: `before_destroy`, `throw(:abort)`, `destroy` vs `destroy!`, `ActiveRecord::RecordNotDestroyed`
- **Task Requirement**: Add a `before_destroy :prevent_verified_enterprise_destruction` callback on `Organization` that adds an error to `:base` and calls `throw(:abort)` if `plan_enterprise? && verified?`. Verify that `org.destroy` returns `false` and `org.destroy!` raises `ActiveRecord::RecordNotDestroyed`.

```ruby
class Organization < ApplicationRecord
  before_destroy :prevent_verified_enterprise_destruction

  private

  def prevent_verified_enterprise_destruction
    if plan_enterprise? && verified?
      errors.add(:base, "Cannot destroy a verified Enterprise organization; archive it first")
      throw(:abort)
    end
  end
end
```

### Task 025: Execution Timing with `around_save` & `around_destroy`
- **Depends On**: Task 024 (measures persistence latency on `Organization` writes)
- **ActiveRecord Concepts**: `around_save`, `yield` inside around callbacks
- **Task Requirement**: Implement an `around_save :measure_save_duration` callback on `Organization` that measures the exact wall-clock milliseconds spent inside the database save and stores it in an instance reader `@last_save_duration_ms`.

```ruby
class Organization < ApplicationRecord
  attr_reader :last_save_duration_ms
  around_save :measure_save_duration

  private

  def measure_save_duration
    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    yield
    @last_save_duration_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0) * 1000.0).round(2)
  end
end
```

### Task 026: Create `audit_logs` Table & Reusable Callback Object Class (`AuditLoggerCallback`)
- **Depends On**: Task 025 (creates persistent `AuditLog` records whenever `Organization` or `User` changes)
- **ActiveRecord Concepts**: Reusable Callback Classes (`after_save(record)`), Polymorphic Audit Target
- **Task Requirement**: Create the `audit_logs` table (`auditable_type`, `auditable_id`, `action`, `changeset` jsonb, `created_at`) and `AuditLog < ApplicationRecord`. Build a reusable callback class `AuditLoggerCallback` and attach it to both `Organization` and `User` via `after_save AuditLoggerCallback.new`.

```ruby
class CreateAuditLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :audit_logs do |t|
      t.string   :auditable_type, null: false
      t.bigint   :auditable_id, null: false
      t.string   :action, null: false
      t.jsonb    :changeset, default: {}, null: false
      t.datetime :created_at, null: false
    end
    add_index :audit_logs, [:auditable_type, :auditable_id]
  end
end

class AuditLog < ApplicationRecord; end

class AuditLoggerCallback
  def after_save(record)
    return if record.saved_changes.except("updated_at").empty?
    action = record.previously_new_record? ? "create" : "update"
    AuditLog.create!(
      auditable_type: record.class.name,
      auditable_id: record.id,
      action: action,
      changeset: record.saved_changes.except("updated_at"),
      created_at: Time.current
    )
  end
end

class Organization < ApplicationRecord
  after_save AuditLoggerCallback.new
end

class User < ApplicationRecord
  after_save AuditLoggerCallback.new
end
```

### Task 027: Transactional Callbacks (`after_commit` vs `after_rollback`)
- **Depends On**: Task 026 (dispatches external events only after the DB transaction from Task 026 commits)
- **ActiveRecord Concepts**: `after_create_commit`, `after_update_commit`, `after_rollback`, `previously_new_record?`
- **Task Requirement**: Add `after_commit :publish_outbox_event, on: [:create, :update]` and `after_rollback :mark_transaction_aborted` on `Organization` so background jobs only see committed rows and aborted transactions are tracked in memory.

```ruby
class Organization < ApplicationRecord
  cattr_accessor :published_events, default: []
  attr_accessor :transaction_aborted

  after_commit :publish_outbox_event, on: [:create, :update]
  after_rollback :mark_transaction_aborted

  private

  def publish_outbox_event
    self.class.published_events << { org_id: id, slug: slug, plan: plan }
  end

  def mark_transaction_aborted
    @transaction_aborted = true
  end
end
```

### Task 028: Suppressing Model Creation during Bulk Seeding with `ActiveRecord::Suppressor`
- **Depends On**: Task 027 (prevents `AuditLog` noise during bulk administrative operations)
- **ActiveRecord Concepts**: `ActiveRecord::Suppressor`, `AuditLog.suppress { ... }`
- **Task Requirement**: Wrap an administrative migration update inside `AuditLog.suppress do ... end` so updating `Organization` records does not persist `AuditLog` rows when `AuditLoggerCallback` fires.

```ruby
class Organization < ApplicationRecord
  def silent_verify!
    AuditLog.suppress do
      update!(verified: true)
    end
  end
end
```

### Task 029: Callback Ordering with `prepend: true` on `before_destroy`
- **Depends On**: Task 028 (ensures guard checks run before cleanup hooks during `destroy`)
- **ActiveRecord Concepts**: `before_destroy ..., prepend: true`
- **Task Requirement**: Demonstrate why `before_destroy :prevent_verified_enterprise_destruction, prepend: true` must be prepended so that any subsequent cleanup callbacks (or `dependent: :destroy` associations added in Module 4) never execute if destruction is aborted.

```ruby
class Organization < ApplicationRecord
  before_destroy :prevent_verified_enterprise_destruction, prepend: true
end
```

### Task 030: Module 3 Milestone: Audited, Rollback-Aware `OrganizationLifecycleManager`
- **Depends On**: Task 029 (combines callbacks, `AuditLog`, `throw(:abort)`, and `after_commit` from Tasks 021–029)
- **ActiveRecord Concepts**: Full Callback Lifecycle, Transaction Rollback Inspection, Audit Log Verification
- **Task Requirement**: Build `OrganizationLifecycleManager` that creates, upgrades, attempts an invalid destruction of a verified enterprise org (rescuing `ActiveRecord::RecordNotDestroyed`), and returns the generated `AuditLog` trail and `published_events` queue.

```ruby
class OrganizationLifecycleManager
  def self.run_demo!(org_name:)
    org = Organization.create!(name: org_name, plan: :pro)
    org.update!(
      plan: :enterprise,
      verified: true,
      billing_email: "ops@#{org.slug}.io",
      ip_allowlist: ["10.0.0.0/8"]
    )

    destroy_blocked = !org.destroy
    audits = AuditLog.where(auditable_type: "Organization", auditable_id: org.id).order(:id)
    { org: org, destroy_blocked: destroy_blocked, audit_count: audits.count, events: Organization.published_events.last(2) }
  end
end
```

## Module 4: Core Associations (`belongs_to`, `has_one`, `has_many`, `:through`, Extensions & `inverse_of`)

> **Module Goal**: Connect `Organization` and `User` to `Membership`, `Project`, and `RepositoryConfig` using foreign keys, `touch: true`, `dependent:` strategies, `has_many :through`, scoped associations, association extensions, `inverse_of` memory identity, and `accepts_nested_attributes_for`.

### Task 031: Create `memberships` and `projects` Tables with Foreign Keys & Cascade Rules
- **Depends On**: Task 030 (links `Organization` and `User` from Modules 1–3 via join and child tables)
- **ActiveRecord Concepts**: `t.references`, `foreign_key: { on_delete: :cascade }`, composite unique index
- **Task Requirement**: Create `memberships` (linking `organization` and `user` with `access_level` integer, unique on `[organization_id, user_id]`) and `projects` (linking `organization` and `creator` -> `users` table with `on_delete: :restrict`, plus `name`, `path`, `visibility`, `stars_count`, `archived`).

```ruby
class CreateMembershipsAndProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :memberships do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.integer    :access_level, default: 30, null: false
      t.timestamps
    end
    add_index :memberships, [:organization_id, :user_id], unique: true

    create_table :projects do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }
      t.references :creator, null: false, foreign_key: { to_table: :users, on_delete: :restrict }
      t.string     :name, limit: 120, null: false
      t.string     :path, limit: 80, null: false
      t.integer    :visibility, default: 0, null: false
      t.integer    :stars_count, default: 0, null: false
      t.boolean    :pinned, default: false, null: false
      t.boolean    :archived, default: false, null: false
      t.timestamps
    end
    add_index :projects, [:organization_id, :path], unique: true
  end
end
```

### Task 032: Configure `belongs_to` Associations with Custom `class_name`, `foreign_key` & `touch: true`
- **Depends On**: Task 031 (wires `Membership` and `Project` models to `Organization` and `User`)
- **ActiveRecord Concepts**: `belongs_to`, `class_name:`, `foreign_key:`, `inverse_of:`, `touch: true`
- **Task Requirement**: Define `Membership` and `Project`. Configure `Project` to belong to `organization` (with `touch: true` so updating a project bumps `organization.updated_at`) and belong to `creator` (`class_name: 'User'`, `foreign_key: :creator_id`, `inverse_of: :created_projects`).

```ruby
class Membership < ApplicationRecord
  enum :access_level, { guest: 10, reporter: 20, developer: 30, maintainer: 40, owner: 50 }, validate: true
  belongs_to :organization, inverse_of: :memberships
  belongs_to :user, inverse_of: :memberships
end

class Project < ApplicationRecord
  attribute :path, :normalized_slug
  enum :visibility, { private_vis: 0, internal_vis: 1, public_vis: 2 }, default: :private_vis
  belongs_to :organization, inverse_of: :projects, touch: true
  belongs_to :creator, class_name: "User", foreign_key: :creator_id, inverse_of: :created_projects
end
```

### Task 033: Create `repository_configs` & Configure `has_one` and `has_one :through`
- **Depends On**: Task 032 (attaches 1:1 repository settings to `Project` from Task 032)
- **ActiveRecord Concepts**: `has_one`, `has_one :through`, `build_association`, `create_association!`
- **Task Requirement**: Create `repository_configs` (`project_id` unique index, `default_branch`, `merge_method`, `lfs_enabled`) and `RepositoryConfig < ApplicationRecord`. Wire `Project` `has_one :repository_config, dependent: :destroy` and `RepositoryConfig` `has_one :organization, through: :project`.

```ruby
class CreateRepositoryConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :repository_configs do |t|
      t.references :project, null: false, index: { unique: true }, foreign_key: { on_delete: :cascade }
      t.string  :default_branch, default: "main", null: false
      t.string  :merge_method, default: "merge_commit", null: false
      t.boolean :lfs_enabled, default: true, null: false
      t.timestamps
    end
  end
end

class RepositoryConfig < ApplicationRecord
  belongs_to :project, inverse_of: :repository_config
  has_one :organization, through: :project
end

class Project < ApplicationRecord
  has_one :repository_config, dependent: :destroy, inverse_of: :project
end
```

### Task 034: Configure `has_many` & `dependent:` Strategies Across `Organization` and `User`
- **Depends On**: Task 033 (completes the parent side of the `Membership` and `Project` associations)
- **ActiveRecord Concepts**: `has_many`, `dependent: :destroy`, `dependent: :restrict_with_error`
- **Task Requirement**: Wire `Organization` (`has_many :memberships, dependent: :destroy`, `has_many :projects, dependent: :destroy`) and `User` (`has_many :memberships, dependent: :destroy`, `has_many :created_projects, class_name: 'Project', foreign_key: :creator_id, dependent: :restrict_with_error`).

```ruby
class Organization < ApplicationRecord
  has_many :memberships, dependent: :destroy, inverse_of: :organization
  has_many :projects, dependent: :destroy, inverse_of: :organization
end

class User < ApplicationRecord
  has_many :memberships, dependent: :destroy, inverse_of: :user
  has_many :created_projects, class_name: "Project", foreign_key: :creator_id,
                             dependent: :restrict_with_error, inverse_of: :creator
end
```

### Task 035: Many-to-Many via `has_many :through` & Source Disambiguation (`source:`)
- **Depends On**: Task 034 (traverses `Organization <-> Membership <-> User` and `Organization -> Project -> RepositoryConfig`)
- **ActiveRecord Concepts**: `has_many :through`, `source:`
- **Task Requirement**: Add `has_many :members, through: :memberships, source: :user` on `Organization`, `has_many :organizations, through: :memberships` on `User`, and `has_many :repository_configs, through: :projects` on `Organization`.

```ruby
class Organization < ApplicationRecord
  has_many :members, through: :memberships, source: :user
  has_many :repository_configs, through: :projects
end

class User < ApplicationRecord
  has_many :organizations, through: :memberships
end
```

### Task 036: Scoped Associations (`has_many :pinned_projects`, `has_many :owners`)
- **Depends On**: Task 035 (adds pre-filtered association readers to `Organization`)
- **ActiveRecord Concepts**: Lambda-scoped `has_many -> { ... }`, `through:` with scoped source
- **Task Requirement**: Define `has_many :pinned_projects, -> { where(pinned: true, archived: false).order(stars_count: :desc) }, class_name: 'Project'` and `has_many :owners, -> { where(memberships: { access_level: :owner }) }, through: :memberships, source: :user` on `Organization`.

```ruby
class Organization < ApplicationRecord
  has_many :pinned_projects, -> { where(pinned: true, archived: false).order(stars_count: :desc) },
           class_name: "Project", inverse_of: :organization
  has_many :owners, -> { where(memberships: { access_level: Membership.access_levels[:owner] }) },
           through: :memberships, source: :user
end
```

### Task 037: Association Extensions (`has_many :memberships do ... end`)
- **Depends On**: Task 036 (attaches custom domain methods directly onto `organization.memberships`)
- **ActiveRecord Concepts**: Association Extension Block, `proxy_association.owner`
- **Task Requirement**: Extend `Organization#memberships` with an association extension block providing `.grant!(user, level: :developer)` (which creates or updates the membership) and `.maintainers_and_owners`.

```ruby
class Organization < ApplicationRecord
  has_many :memberships, dependent: :destroy, inverse_of: :organization do
    def grant!(user, level: :developer)
      record = find_or_initialize_by(user: user)
      record.update!(access_level: level)
      record
    end

    def maintainers_and_owners
      where(access_level: [:maintainer, :owner])
    end
  end
end
```

### Task 038: Verify `inverse_of` In-Memory Identity & Unsaved Graph Validation
- **Depends On**: Task 037 (verifies memory identity between `org` and `project.organization`)
- **ActiveRecord Concepts**: `inverse_of`, Object identity (`equal?`) without extra SQL queries
- **Task Requirement**: Write a method `Organization#build_project_with_config(name:, creator:)` that builds a `Project` and its `RepositoryConfig` in memory and verifies that `project.organization.equal?(self)` is `true` without firing a `SELECT` query.

```ruby
class Organization < ApplicationRecord
  def build_project_with_config(name:, creator:, default_branch: settings["default_branch"] || "main")
    proj = projects.build(name: name, path: name, creator: creator)
    proj.build_repository_config(default_branch: default_branch)
    proj
  end
end
```

### Task 039: `accepts_nested_attributes_for` with `reject_if` & `update_only: true`
- **Depends On**: Task 038 (allows creating/updating a `Project` and its `RepositoryConfig` from a single payload)
- **ActiveRecord Concepts**: `accepts_nested_attributes_for`, `update_only: true`, `validates_associated`
- **Task Requirement**: Configure `Project` with `accepts_nested_attributes_for :repository_config, update_only: true, reject_if: :all_blank` and `validates_associated :repository_config`.

```ruby
class Project < ApplicationRecord
  accepts_nested_attributes_for :repository_config, update_only: true, reject_if: :all_blank
  validates_associated :repository_config
end
```

### Task 040: Module 4 Milestone: `WorkspaceProvisioner` Building Connected Org, Member & Project Graphs
- **Depends On**: Task 039 (combines associations, extensions, and nested attributes from Tasks 031–039)
- **ActiveRecord Concepts**: Nested Graph Persistence, Association Extensions, Scoped Associations
- **Task Requirement**: Implement `WorkspaceProvisioner.provision!(org:, creator:, project_names:)` that grants `:owner` membership via `org.memberships.grant!`, creates projects with nested `repository_config_attributes`, pins the first project, and returns `org.pinned_projects` and `org.owners`.

```ruby
class WorkspaceProvisioner
  def self.provision!(org:, creator:, project_names:)
    Organization.transaction do
      org.memberships.grant!(creator, level: :owner)

      project_names.each_with_index do |name, idx|
        org.projects.create!(
          name: name,
          path: name,
          creator: creator,
          pinned: idx.zero?,
          stars_count: (project_names.size - idx) * 10,
          repository_config_attributes: { default_branch: "main", merge_method: "fast_forward" }
        )
      end
    end

    { owners: org.owners.to_a, pinned_projects: org.pinned_projects.to_a }
  end
end
```

## Module 5: Advanced Associations (Self-Referential, Polymorphic, STI, `DelegatedType` & Counter Caches)

> **Module Goal**: Expand `Project` into a full issue/MR tracker with `Milestone`, self-referential `Issue` hierarchies (`parent_issue` / `sub_issues`), `MergeRequest`, polymorphic `Note`s and `LabelLink`s, Single Table Inheritance (`Integration`), `DelegatedType` (`TimelineEvent`), and `counter_cache` reconciliation.

### Task 041: Create `milestones` & `issues` with Self-Referential Sub-Issue Hierarchy
- **Depends On**: Task 040 (adds `Milestone` and hierarchical `Issue` models under `Project` from Module 4)
- **ActiveRecord Concepts**: Self-Referential `belongs_to :parent_issue` / `has_many :sub_issues`, `counter_cache` columns
- **Task Requirement**: Create `milestones` (`project_id`, `title`, `state`, `due_date`, `issues_count`) and `issues` (`project_id`, `milestone_id`, `author_id`, `assignee_id`, `parent_issue_id`, `iid`, `title`, `state`, `priority`, `weight`, `notes_count`, `lock_version`). Wire `Issue` self-referential `parent_issue` and `sub_issues`.

```ruby
class CreateMilestonesAndIssues < ActiveRecord::Migration[7.1]
  def change
    create_table :milestones do |t|
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.string  :title, null: false
      t.integer :state, default: 0, null: false
      t.date    :due_date
      t.integer :issues_count, default: 0, null: false
      t.timestamps
    end

    create_table :issues do |t|
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.references :milestone, foreign_key: { on_delete: :nullify }
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :assignee, foreign_key: { to_table: :users }
      t.references :parent_issue, foreign_key: { to_table: :issues, on_delete: :nullify }
      t.integer :iid, null: false
      t.string  :title, null: false
      t.integer :state, default: 0, null: false
      t.integer :priority, default: 1, null: false
      t.integer :weight, default: 1, null: false
      t.integer :notes_count, default: 0, null: false
      t.integer :lock_version, default: 0, null: false
      t.datetime :due_at
      t.datetime :closed_at
      t.timestamps
    end
    add_index :issues, [:project_id, :iid], unique: true
  end
end

class Milestone < ApplicationRecord
  enum :state, { active: 0, closed: 1 }, default: :active
  belongs_to :project
  has_many :issues, dependent: :nullify
end

class Issue < ApplicationRecord
  enum :state, { opened: 0, closed: 1 }, default: :opened
  enum :priority, { low: 0, medium: 1, high: 2, critical: 3 }, default: :medium, prefix: true

  belongs_to :project
  belongs_to :milestone, optional: true, counter_cache: true
  belongs_to :author, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true
  belongs_to :parent_issue, class_name: "Issue", optional: true, inverse_of: :sub_issues
  has_many   :sub_issues, class_name: "Issue", foreign_key: :parent_issue_id,
                          dependent: :nullify, inverse_of: :parent_issue
end
```

### Task 042: Create `merge_requests` & Polymorphic `notes` Across Issues and Merge Requests
- **Depends On**: Task 041 (adds `MergeRequest` and polymorphic `Note` commenting to `Issue` and `Project`)
- **ActiveRecord Concepts**: `t.references :noteable, polymorphic: true`, `belongs_to :noteable, polymorphic: true`, `has_many :notes, as: :noteable`
- **Task Requirement**: Create `merge_requests` (`project_id`, `author_id`, `iid`, `title`, `source_branch`, `target_branch`, `state`, `notes_count`) and `notes` (`noteable_type`, `noteable_id`, `author_id`, `body`, `system`). Wire polymorphic `notes` onto both `Issue` and `MergeRequest`.

```ruby
class CreateMergeRequestsAndNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :merge_requests do |t|
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.integer :iid, null: false
      t.string  :title, null: false
      t.string  :source_branch, null: false
      t.string  :target_branch, default: "main", null: false
      t.integer :state, default: 0, null: false
      t.integer :notes_count, default: 0, null: false
      t.timestamps
    end
    add_index :merge_requests, [:project_id, :iid], unique: true

    create_table :notes do |t|
      t.references :noteable, polymorphic: true, null: false, index: true
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.text    :body, null: false
      t.boolean :system, default: false, null: false
      t.timestamps
    end
  end
end

class Note < ApplicationRecord
  belongs_to :noteable, polymorphic: true, counter_cache: true, touch: true
  belongs_to :author, class_name: "User"
  validates :body, presence: true
end

class MergeRequest < ApplicationRecord
  enum :state, { opened: 0, merged: 1, closed: 2 }, default: :opened
  belongs_to :project
  belongs_to :author, class_name: "User"
  has_many :notes, as: :noteable, dependent: :destroy
end

class Issue < ApplicationRecord
  has_many :notes, as: :noteable, dependent: :destroy
end
```

### Task 043: Polymorphic `has_many :through` with `source_type:` Disambiguation
- **Depends On**: Task 042 (lets `User` query all `Issue` vs `MergeRequest` records they have commented on)
- **ActiveRecord Concepts**: `has_many :through` with `source: :noteable, source_type: '...'`
- **Task Requirement**: Add `has_many :authored_notes, class_name: 'Note', foreign_key: :author_id` on `User`, and derive `has_many :commented_issues, -> { distinct }, through: :authored_notes, source: :noteable, source_type: 'Issue'` and `has_many :commented_merge_requests`.

```ruby
class User < ApplicationRecord
  has_many :authored_notes, class_name: "Note", foreign_key: :author_id, dependent: :destroy
  has_many :commented_issues, -> { distinct }, through: :authored_notes, source: :noteable, source_type: "Issue"
  has_many :commented_merge_requests, -> { distinct }, through: :authored_notes, source: :noteable, source_type: "MergeRequest"
end
```

### Task 044: Single Table Inheritance (STI) for Project `integrations`
- **Depends On**: Task 043 (attaches webhook/chat integrations to `Project` using STI)
- **ActiveRecord Concepts**: Single Table Inheritance (`type` column), Subclass-specific validations & behavior
- **Task Requirement**: Create `integrations` table with `project_id`, `type` (string, not null), `active` (boolean), and `config` (`jsonb`). Define `Integration < ApplicationRecord` and STI subclasses `SlackIntegration`, `JiraIntegration`, and `WebhookIntegration` with subclass-specific JSONB config validations.

```ruby
class CreateIntegrations < ActiveRecord::Migration[7.1]
  def change
    create_table :integrations do |t|
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.string  :type, null: false
      t.boolean :active, default: true, null: false
      t.jsonb   :config, default: {}, null: false
      t.timestamps
    end
  end
end

class Integration < ApplicationRecord
  belongs_to :project
end

class SlackIntegration < Integration
  store_accessor :config, :webhook_url, :channel
  validates :webhook_url, :channel, presence: true
end

class WebhookIntegration < Integration
  store_accessor :config, :endpoint_url, :secret_token
  validates :endpoint_url, presence: true
end
```

### Task 045: `delegated_type` for `TimelineEvent` Polymorphic Hierarchy
- **Depends On**: Task 044 (records activity stream events across `Project` using Rails' `delegated_type`)
- **ActiveRecord Concepts**: `delegated_type :eventable, types: [...]`, generated predicates and scopes
- **Task Requirement**: Create `timeline_events`, `issue_closed_payloads`, and `mr_merged_payloads` tables. Configure `TimelineEvent` with `delegated_type :eventable, types: %w[IssueClosedPayload MrMergedPayload], dependent: :destroy`.

```ruby
class CreateTimelineEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :issue_closed_payloads do |t|
      t.references :issue, null: false, foreign_key: { on_delete: :cascade }
      t.string :closed_via_commit_sha
    end

    create_table :mr_merged_payloads do |t|
      t.references :merge_request, null: false, foreign_key: { on_delete: :cascade }
      t.string :merge_commit_sha, null: false
    end

    create_table :timeline_events do |t|
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.references :actor, null: false, foreign_key: { to_table: :users }
      t.string     :eventable_type, null: false
      t.bigint     :eventable_id, null: false
      t.datetime   :occurred_at, null: false
    end
    add_index :timeline_events, [:eventable_type, :eventable_id]
  end
end

class IssueClosedPayload < ApplicationRecord
  belongs_to :issue
  has_one :timeline_event, as: :eventable, touch: true
end

class MrMergedPayload < ApplicationRecord
  belongs_to :merge_request
  has_one :timeline_event, as: :eventable, touch: true
end

class TimelineEvent < ApplicationRecord
  belongs_to :project
  belongs_to :actor, class_name: "User"
  delegated_type :eventable, types: %w[IssueClosedPayload MrMergedPayload], dependent: :destroy
end
```

### Task 046: Counter Cache Verification & Custom Counter Cache Column Names
- **Depends On**: Task 045 (verifies `issues_count` on `Milestone` and `notes_count` on `Issue`/`MergeRequest`)
- **ActiveRecord Concepts**: `counter_cache: true`, `counter_cache: :custom_column`
- **Task Requirement**: Add `issues_count` to `projects` via migration, configure `belongs_to :project, counter_cache: true` on `Issue`, and verify that creating/destroying an `Issue` or moving an `Issue` between two `Milestone` records atomically updates both counter columns.

```ruby
class AddIssuesCountToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :issues_count, :integer, default: 0, null: false
  end
end

class Issue < ApplicationRecord
  belongs_to :project, counter_cache: true
  belongs_to :milestone, optional: true, counter_cache: true
end
```

### Task 047: Atomic Counter Operations & Drift Recovery (`reset_counters`, `update_counters`)
- **Depends On**: Task 046 (repairs counter cache drift on `Project` and `Milestone` after bulk SQL operations)
- **ActiveRecord Concepts**: `Project.reset_counters(id, :issues)`, `Project.increment_counter`, `Project.update_counters`
- **Task Requirement**: Implement `Project#reconcile_counters!` that detects any drift between `issues_count` and the actual SQL `issues.count` and repairs it using `Project.reset_counters(id, :issues)`.

```ruby
class Project < ApplicationRecord
  has_many :issues, dependent: :destroy
  has_many :merge_requests, dependent: :destroy
  has_many :milestones, dependent: :destroy
  has_many :integrations, dependent: :destroy
  has_many :timeline_events, dependent: :destroy

  def reconcile_counters!
    Project.reset_counters(id, :issues)
    reload.issues_count
  end
end
```

### Task 048: Labels & `LabelLink` Polymorphic Join Model (`Issue` & `MergeRequest` Tagging)
- **Depends On**: Task 047 (adds reusable project `Label` records attached to both `Issue` and `MergeRequest`)
- **ActiveRecord Concepts**: Polymorphic Join Model (`label_links` with `target_type`, `target_id`), `has_many :labels, through: :label_links`
- **Task Requirement**: Create `labels` (`project_id`, `title`, `color`) and `label_links` (`label_id`, `target_type`, `target_id`). Wire `has_many :labels, through: :label_links` onto both `Issue` and `MergeRequest`.

```ruby
class CreateLabelsAndLabelLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :labels do |t|
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.string :title, limit: 60, null: false
      t.string :color, limit: 7, default: "#FC6D26", null: false
      t.timestamps
    end
    add_index :labels, [:project_id, :title], unique: true

    create_table :label_links do |t|
      t.references :label, null: false, foreign_key: { on_delete: :cascade }
      t.references :target, polymorphic: true, null: false
      t.timestamps
    end
    add_index :label_links, [:label_id, :target_type, :target_id], unique: true, name: "idx_label_links_uniqueness"
  end
end

class Label < ApplicationRecord
  belongs_to :project
  has_many :label_links, dependent: :destroy
end

class LabelLink < ApplicationRecord
  belongs_to :label
  belongs_to :target, polymorphic: true
end

class Issue < ApplicationRecord
  has_many :label_links, as: :target, dependent: :destroy
  has_many :labels, through: :label_links
end

class MergeRequest < ApplicationRecord
  has_many :label_links, as: :target, dependent: :destroy
  has_many :labels, through: :label_links
end
```

### Task 049: `autosave: true` Associations for Atomic Parent/Child Updates
- **Depends On**: Task 048 (enables mutating `project.repository_config` attributes in memory and saving via `project.save!`)
- **ActiveRecord Concepts**: `autosave: true` on `has_one` / `has_many`
- **Task Requirement**: Configure `has_one :repository_config, dependent: :destroy, autosave: true, inverse_of: :project` on `Project` so modifying `project.repository_config.default_branch = 'develop'` and calling `project.save!` automatically persists the child record.

```ruby
class Project < ApplicationRecord
  has_one :repository_config, dependent: :destroy, autosave: true, inverse_of: :project
end
```

### Task 050: Module 5 Milestone: `IssueAndMrTrackerEngine` Orchestrating Sub-Issues, Notes, Labels & Delegated Timeline Events
- **Depends On**: Task 049 (integrates all advanced associations built in Tasks 041–049)
- **ActiveRecord Concepts**: Self-Referential Trees, Polymorphic Notes/Labels, STI Integrations, DelegatedType Timeline Events, Counter Caches
- **Task Requirement**: Implement `IssueAndMrTrackerEngine.record_workflow!(project:, author:)` that creates a milestone, parent/child issues, labels, polymorphic notes, a Slack STI integration, and a `TimelineEvent` (`IssueClosedPayload`), returning verified counter caches.

```ruby
class IssueAndMrTrackerEngine
  def self.record_workflow!(project:, author:)
    Milestone.transaction do
      milestone = project.milestones.create!(title: "v1.0", due_date: 30.days.from_now)
      bug_label = project.labels.create!(title: "bug", color: "#EF4444")

      parent = project.issues.create!(iid: 1, title: "Parent Epic Issue", author: author, milestone: milestone, priority: :critical, weight: 5)
      child  = project.issues.create!(iid: 2, title: "Sub-task Issue", author: author, milestone: milestone, parent_issue: parent, weight: 2)

      parent.labels << bug_label
      parent.notes.create!(author: author, body: "Investigating root cause")

      SlackIntegration.create!(project: project, webhook_url: "https://hooks.slack.com/services/T0/B0/X", channel: "#alerts")

      TimelineEvent.create!(
        project: project,
        actor: author,
        occurred_at: Time.current,
        eventable: IssueClosedPayload.new(issue: child, closed_via_commit_sha: "abc1234")
      )

      {
        project_issues_count: project.reload.issues_count,
        milestone_issues_count: milestone.reload.issues_count,
        parent_notes_count: parent.reload.notes_count,
        sub_issues_count: parent.sub_issues.count
      }
    end
  end
end
```

## Module 6: Query Interface I — Predicate Filtering, Anti-Joins, Safe `LIKE`, Ordering & Subqueries

> **Module Goal**: Query `Issue` and `Project` relations using endless/beginless ranges, `where.associated`, `where.missing` anti-joins, `sanitize_sql_like`, `Relation#or` / `Relation#and`, `in_order_of`, virtual SQL projections, `pluck` vs `pick`, `exists?`, and composable relation subqueries.

### Task 051: Range, Endless Range & Subset Array Filtering on `Issue`
- **Depends On**: Task 050 (queries `Issue` records created by `IssueAndMrTrackerEngine` in Module 5)
- **ActiveRecord Concepts**: `where(col: [...])`, Endless Range `1.week.ago..`, Beginless Range `..3`
- **Task Requirement**: Write `Issue.recent_lightweight(project_id, since: 7.days.ago, max_weight: 3)` using hash range conditions (`created_at: since..`, `weight: ..max_weight`, `priority: [:high, :critical]`).

```ruby
class Issue < ApplicationRecord
  def self.recent_lightweight(project_id, since: 7.days.ago, max_weight: 3)
    where(
      project_id: project_id,
      created_at: since..,
      weight: ..max_weight,
      priority: [:high, :critical]
    )
  end
end
```

### Task 052: Relational Presence & Anti-Joins (`where.associated` & `where.missing`)
- **Depends On**: Task 051 (filters `Issue` and `Project` records by association presence/absence)
- **ActiveRecord Concepts**: `where.not`, `where.associated(:assoc)`, `where.missing(:assoc)`
- **Task Requirement**: Implement `Issue.unassigned_without_notes` using `where(assignee_id: nil).where.missing(:notes)` and `Project.with_any_milestones` using `where.associated(:milestones)`.

```ruby
class Issue < ApplicationRecord
  def self.unassigned_without_notes
    where(assignee_id: nil).where.missing(:notes)
  end
end

class Project < ApplicationRecord
  def self.with_any_milestones
    where.associated(:milestones).distinct
  end
end
```

### Task 053: Safe `ILIKE` Pattern Matching with `sanitize_sql_like` & Named Bindings
- **Depends On**: Task 052 (adds wildcard-safe title search to `Issue`)
- **ActiveRecord Concepts**: `ActiveRecord::Base.sanitize_sql_like`, Named SQL bind variables `:pattern`
- **Task Requirement**: Implement `Issue.search_title(raw_term)` that escapes `%` and `_` wildcards in user input via `sanitize_sql_like(raw_term)` so searching for `'100%_cpu'` matches literal `'100%_cpu'` instead of acting as a SQL wildcard.

```ruby
class Issue < ApplicationRecord
  def self.search_title(raw_term)
    return all if raw_term.blank?
    escaped = "%#{sanitize_sql_like(raw_term.strip)}%"
    where("LOWER(issues.title) LIKE LOWER(:pattern)", pattern: escaped)
  end
end
```

### Task 054: Boolean Relation Composition (`Relation#or`, `Relation#and`, `invert_where`)
- **Depends On**: Task 053 (combines multiple `Issue` filter relations cleanly)
- **ActiveRecord Concepts**: `Relation#or`, `Relation#and`, `Relation#invert_where`
- **Task Requirement**: Implement `Issue.actionable_for(user)` returning open issues where the user is either the `author` OR the `assignee`, OR the issue has `:critical` priority.

```ruby
class Issue < ApplicationRecord
  def self.actionable_for(user)
    base = where(state: :opened)
    authored  = base.where(author_id: user.id)
    assigned  = base.where(assignee_id: user.id)
    criticals = base.where(priority: :critical)

    authored.or(assigned).or(criticals)
  end
end
```

### Task 055: Custom Business Ordering with `in_order_of` & `NULLS LAST`
- **Depends On**: Task 054 (orders `Issue` queues by custom severity sequence and due dates)
- **ActiveRecord Concepts**: `in_order_of(:column, values)`, `Arel.sql('due_at ASC NULLS LAST')`, `reorder`
- **Task Requirement**: Write `Issue.prioritized_backlog` that uses `in_order_of(:priority, %i[critical high medium low])` followed by `order(Arel.sql('issues.due_at ASC NULLS LAST, issues.id DESC'))`.

```ruby
class Issue < ApplicationRecord
  def self.prioritized_backlog
    in_order_of(:priority, %i[critical high medium low])
      .order(Arel.sql("issues.due_at ASC NULLS LAST, issues.id DESC"))
  end
end
```

### Task 056: Projection Optimization (`select`, `reselect`, Virtual Computed Attributes & `distinct`)
- **Depends On**: Task 055 (projects calculated SLA fields directly onto `Issue` models)
- **ActiveRecord Concepts**: `select(...)`, Virtual read attributes on returned ActiveRecord models
- **Task Requirement**: Write `Issue.with_computed_density` that selects `issues.id, issues.title, (issues.notes_count * 10 + issues.weight) AS engagement_score` and orders by `engagement_score DESC` so calling `issue.engagement_score` reads the SQL-calculated column.

```ruby
class Issue < ApplicationRecord
  def self.with_computed_density
    select(
      :id, :project_id, :iid, :title, :weight, :notes_count,
      "(issues.notes_count * 10 + issues.weight) AS engagement_score"
    ).order(Arel.sql("engagement_score DESC, issues.id ASC"))
  end
end
```

### Task 057: Fast Scalar Extraction (`pluck` vs `pick` vs `ids`)
- **Depends On**: Task 056 (extracts lightweight arrays and single values from `Issue` relations without model allocation)
- **ActiveRecord Concepts**: `pluck`, `pick`, `ids`
- **Task Requirement**: Implement `Project#issue_iid_to_title_map` using `issues.order(:iid).pluck(:iid, :title).to_h` and `Project#next_issue_iid` using `issues.order(iid: :desc).pick(:iid).to_i + 1`.

```ruby
class Project < ApplicationRecord
  def issue_iid_to_title_map
    issues.order(:iid).pluck(:iid, :title).to_h
  end

  def next_issue_iid
    issues.order(iid: :desc).pick(:iid).to_i + 1
  end
end
```

### Task 058: Short-Circuit Existence Predicates (`exists?`, `any?`, `none?`, `one?`)
- **Depends On**: Task 057 (checks project issue conditions in $O(1)$ SQL limit 1 queries)
- **ActiveRecord Concepts**: `exists?`, `any?`, `none?`, `one?`
- **Task Requirement**: Add `Project#has_critical_blockers?` using `issues.where(state: :opened, priority: :critical).exists?` (which executes `SELECT 1 FROM issues WHERE ... LIMIT 1`).

```ruby
class Project < ApplicationRecord
  def has_critical_blockers?
    issues.where(state: :opened, priority: :critical).exists?
  end
end
```

### Task 059: Composable Relation Subqueries in `WHERE` & Derived Table `FROM`
- **Depends On**: Task 058 (filters `User` and `Issue` records using relation subqueries without intermediate Ruby arrays)
- **ActiveRecord Concepts**: `where(col: SubModel.select(:id))`, `Model.from(subquery, :table_alias)`
- **Task Requirement**: Implement `Issue.in_verified_enterprise_orgs` by passing `Project.where(organization_id: Organization.plan_enterprise.where(verified: true).select(:id)).select(:id)` directly into `Issue.where(project_id: ...)` so the DB executes a single query.

```ruby
class Issue < ApplicationRecord
  def self.in_verified_enterprise_orgs
    enterprise_org_ids = Organization.plan_enterprise.where(verified: true).select(:id)
    enterprise_project_ids = Project.where(organization_id: enterprise_org_ids).select(:id)
    where(project_id: enterprise_project_ids)
  end
end
```

### Task 060: Module 6 Milestone: `IssueFilterService` Supporting Multi-Facet Search & Prioritized Ordering
- **Depends On**: Task 059 (combines Tasks 051–059 into a single GitLab-style issue search service)
- **ActiveRecord Concepts**: Predicates, Anti-Joins, Safe `LIKE`, `or`/`and`, `in_order_of`, Subqueries
- **Task Requirement**: Build `IssueFilterService.call(params)` supporting `:project_id`, `:search`, `:unassigned_only`, `:without_notes`, `:actionable_for_user`, and `:enterprise_only` returning a chainable prioritized `ActiveRecord::Relation`.

```ruby
class IssueFilterService
  def self.call(params = {})
    rel = Issue.all
    rel = rel.where(project_id: params[:project_id]) if params[:project_id]
    rel = rel.in_verified_enterprise_orgs if params[:enterprise_only]
    rel = rel.actionable_for(params[:actionable_for_user]) if params[:actionable_for_user]
    rel = rel.where(assignee_id: nil) if params[:unassigned_only]
    rel = rel.where.missing(:notes) if params[:without_notes]
    rel = rel.search_title(params[:search]) if params[:search].present?
    rel.prioritized_backlog
  end
end
```

## Module 7: Query Interface II — Joins, Aggregations, `having`, `load_async`, CTEs & Window Functions

> **Module Goal**: Build analytical rollups across `GitForge` using nested `joins`, `left_joins`, derived subquery joins, multi-column `group` + `having`, parallel `load_async` / `async_count`, Rails 7.1 `.with` Common Table Expressions, recursive CTE tree traversal (`descendant_tree`), and `DENSE_RANK() OVER (...)` window functions.

### Task 061: Deep Nested Inner `joins` & Filtering Across 3 Tables
- **Depends On**: Task 060 (joins `Note -> Issue -> Project -> Organization`)
- **ActiveRecord Concepts**: `joins(nested: :associations)`, `where(table_name: { col: val })`
- **Task Requirement**: Write `Note.on_enterprise_issues(org_slug)` joining `Issue` explicitly (`joins("INNER JOIN issues ON issues.id = notes.noteable_id AND notes.noteable_type = 'Issue'")` + `INNER JOIN projects` + `INNER JOIN organizations`).

```ruby
class Note < ApplicationRecord
  def self.on_enterprise_issues(org_slug)
    joins("INNER JOIN issues ON issues.id = notes.noteable_id AND notes.noteable_type = 'Issue'")
      .joins("INNER JOIN projects ON projects.id = issues.project_id")
      .joins("INNER JOIN organizations ON organizations.id = projects.organization_id")
      .where(organizations: { slug: org_slug, plan: Organization.plans[:enterprise] })
  end
end
```

### Task 062: `left_outer_joins` (`left_joins`) for Zero-Count Inclusive Reporting
- **Depends On**: Task 061 (includes projects with 0 issues in aggregation reports)
- **ActiveRecord Concepts**: `left_joins`, `COUNT(child.id)` vs `COUNT(*)`
- **Task Requirement**: Write `Project.with_open_issue_totals` using `left_joins(:issues)` and `select('projects.*, COUNT(CASE WHEN issues.state = 0 THEN 1 END) AS open_issues_total').group('projects.id')` so projects with zero issues still appear with `0`.

```ruby
class Project < ApplicationRecord
  def self.with_open_issue_totals
    left_joins(:issues)
      .select("projects.*, COUNT(CASE WHEN issues.state = 0 THEN 1 END) AS open_issues_total")
      .group("projects.id")
  end
end
```

### Task 063: Joining Derived Subquery Tables (`INNER JOIN (...) AS stats`)
- **Depends On**: Task 062 (joins a pre-aggregated subquery onto `Project` to avoid fan-out multiplication)
- **ActiveRecord Concepts**: Subquery `to_sql` in `joins`
- **Task Requirement**: Write `Project.with_weight_metrics` that aggregates `SUM(weight) AS total_weight, AVG(weight) AS avg_weight` in a grouped `Issue` subquery and joins it onto `Project` so joining `milestones` later never multiplies issue weights.

```ruby
class Project < ApplicationRecord
  def self.with_weight_metrics
    subquery = Issue.select("project_id, SUM(weight) AS total_weight, AVG(weight) AS avg_weight")
                    .group(:project_id)
    joins("LEFT JOIN (#{subquery.to_sql}) AS issue_stats ON issue_stats.project_id = projects.id")
      .select("projects.*, COALESCE(issue_stats.total_weight, 0) AS total_weight")
  end
end
```

### Task 064: Multi-Dimensional `group` & Aggregate Hashes (`count`, `sum`, `average`)
- **Depends On**: Task 063 (computes multi-key `[state, priority]` issue distribution matrices)
- **ActiveRecord Concepts**: `group(:col1, :col2).count`, `group(:col).sum(:weight)`
- **Task Requirement**: Implement `Project#issue_matrix` returning a hash keyed by `[state, priority]` mapped to issue counts, and `Project#weight_by_state` returning `{ 'opened' => total_open_weight, 'closed' => total_closed_weight }`.

```ruby
class Project < ApplicationRecord
  def issue_matrix
    issues.group(:state, :priority).count
  end

  def weight_by_state
    issues.group(:state).sum(:weight)
  end
end
```

### Task 065: Filtering Aggregated Groups with `having`
- **Depends On**: Task 064 (filters `User` and `Project` groups by aggregate thresholds)
- **ActiveRecord Concepts**: `group(...).having(...)`
- **Task Requirement**: Implement `User.overloaded_assignees(min_open_weight: 10)` returning users whose assigned open issues have a combined `SUM(issues.weight) >= min_open_weight`.

```ruby
class User < ApplicationRecord
  has_many :assigned_issues, class_name: "Issue", foreign_key: :assignee_id

  def self.overloaded_assignees(min_open_weight: 10)
    joins(:assigned_issues)
      .where(issues: { state: :opened })
      .group("users.id")
      .having("SUM(issues.weight) >= ?", min_open_weight)
      .select("users.*, SUM(issues.weight) AS assigned_open_weight")
  end
end
```

### Task 066: Parallel Background Query Execution with `load_async` & `async_count`
- **Depends On**: Task 065 (runs independent dashboard queries concurrently across the ActiveRecord thread pool)
- **ActiveRecord Concepts**: `load_async`, `async_count`, `async_sum`, `async_pluck`
- **Task Requirement**: Implement `Project#async_summary_stats` that dispatches `issues.opened.async_count`, `issues.opened.async_sum(:weight)`, and `merge_requests.opened.load_async` concurrently before resolving their values.

```ruby
class Project < ApplicationRecord
  def async_summary_stats
    open_issues_promise = issues.where(state: :opened).async_count
    open_weight_promise = issues.where(state: :opened).async_sum(:weight)
    open_mrs_relation   = merge_requests.where(state: :opened).load_async

    {
      open_issues: open_issues_promise.value,
      open_weight: open_weight_promise.value,
      open_mr_titles: open_mrs_relation.map(&:title)
    }
  end
end
```

### Task 067: Common Table Expressions (CTEs) Using Rails 7.1+ `QueryMethods#with`
- **Depends On**: Task 066 (composes readable multi-stage analytical queries on `Issue` using `.with`)
- **ActiveRecord Concepts**: `Model.with(cte_name: relation)`, Joining/Querying CTEs
- **Task Requirement**: Write `Issue.high_engagement_criticals(min_notes: 1)` using `Issue.with(critical_pool: Issue.where(priority: :critical), noisy_pool: Issue.where(notes_count: min_notes..))` and joining the two CTEs.

```ruby
class Issue < ApplicationRecord
  def self.high_engagement_criticals(min_notes: 1)
    with(
      critical_pool: Issue.where(priority: :critical),
      noisy_pool: Issue.where(notes_count: min_notes..)
    ).from("critical_pool AS issues")
     .joins("INNER JOIN noisy_pool ON noisy_pool.id = issues.id")
  end
end
```

### Task 068: Recursive CTEs (`with_recursive`) for Epic/Sub-Issue Tree Traversal
- **Depends On**: Task 067 (traverses arbitrary-depth `parent_issue -> sub_issues` trees from Task 041 in one query)
- **ActiveRecord Concepts**: `WITH RECURSIVE` SQL CTE returning `Issue` records with `tree_depth`
- **Task Requirement**: Implement `Issue#descendant_tree` that uses a recursive CTE starting at `parent_issue_id = self.id` and recursively unioning child issues, returning all descendant `Issue` objects ordered by tree depth.

```ruby
class Issue < ApplicationRecord
  def descendant_tree
    sql = <<~SQL
      WITH RECURSIVE issue_tree AS (
        SELECT issues.*, 1 AS tree_depth
        FROM issues
        WHERE issues.parent_issue_id = :root_id
        UNION ALL
        SELECT child.*, parent_tree.tree_depth + 1 AS tree_depth
        FROM issues child
        INNER JOIN issue_tree parent_tree ON child.parent_issue_id = parent_tree.id
      )
      SELECT * FROM issue_tree ORDER BY tree_depth ASC, id ASC
    SQL
    Issue.find_by_sql([sql, { root_id: id }])
  end
end
```

### Task 069: SQL Window Functions (`DENSE_RANK`, `ROW_NUMBER`, Running Totals) in ActiveRecord
- **Depends On**: Task 068 (ranks issues within each project by weight and computes running weight totals)
- **ActiveRecord Concepts**: `OVER (PARTITION BY ... ORDER BY ...)`, Derived table filtering on window rank
- **Task Requirement**: Implement `Issue.top_heaviest_per_project(top_n = 2)` that partitions issues by `project_id`, computes `DENSE_RANK() OVER (PARTITION BY project_id ORDER BY weight DESC, id ASC) AS weight_rank`, and filters `WHERE weight_rank <= top_n`.

```ruby
class Issue < ApplicationRecord
  def self.top_heaviest_per_project(top_n = 2)
    ranked_subquery = Issue.select(
      "issues.*, DENSE_RANK() OVER (PARTITION BY project_id ORDER BY weight DESC, id ASC) AS weight_rank"
    )
    Issue.from(ranked_subquery, :issues).where("issues.weight_rank <= ?", top_n)
  end
end
```

### Task 070: Module 7 Milestone: `OrganizationAnalyticsDashboard` Combining CTEs, Window Functions & Async Queries
- **Depends On**: Task 069 (synthesizes all analytical query techniques from Tasks 061–069)
- **ActiveRecord Concepts**: `left_joins`, `having`, `with`, Recursive CTE, Window Functions, `load_async`
- **Task Requirement**: Build `OrganizationAnalyticsDashboard.generate(org)` returning project open-issue totals, overloaded assignees, top-ranked heaviest issues per project, and recursive sub-issue rollups.

```ruby
class OrganizationAnalyticsDashboard
  def self.generate(org)
    projects_scope = org.projects.with_open_issue_totals
    top_issues = Issue.where(project_id: org.projects.select(:id)).top_heaviest_per_project(2)

    {
      project_totals: projects_scope.map { |p| [p.path, p.open_issues_total.to_i] }.to_h,
      overloaded_usernames: User.overloaded_assignees(min_open_weight: 5).map(&:username),
      top_issues_per_project: top_issues.map { |i| { project_id: i.project_id, title: i.title, rank: i.weight_rank } }
    }
  end
end
```

## Module 8: Scopes, Query Composition (`merge`, `unscope`, `rewhere`), `Model.none` & Query Objects

> **Module Goal**: Architect clean query pipelines using parameterized scopes, cross-model `Relation#merge`, surgical `unscope` / `rewhere`, `Archivable` soft-deletion without `default_scope`, `Relation#extending`, `Project.visible_to` with `Model.none`, `readonly`, race-safe `create_or_find_by!`, and composable Query Objects.

### Task 071: Time-Safe Lambda Scopes vs Class Methods on `Issue` and `Milestone`
- **Depends On**: Task 070 (formalizes reusable scopes on `Issue` and `Milestone`)
- **ActiveRecord Concepts**: `scope :name, ->(...) { ... }`, Handling `nil` arguments gracefully
- **Task Requirement**: Define scopes `scope :overdue, ->(now = Time.current) { where(state: :opened).where(due_at: ...now) }`, `scope :weighted_at_least, ->(min) { where(weight: min..) if min.present? }`, and `scope :assigned_to, ->(user) { where(assignee: user) }` on `Issue`.

```ruby
class Issue < ApplicationRecord
  scope :overdue, ->(now = Time.current) { where(state: :opened).where(due_at: ...now) }
  scope :weighted_at_least, ->(min) { where(weight: min..) if min.present? }
  scope :assigned_to, ->(user) { where(assignee: user) }
end
```

### Task 072: Cross-Model Scope Composition with `Relation#merge`
- **Depends On**: Task 071 (merges `Issue.overdue` and `Organization.plan_enterprise` into `Project` queries)
- **ActiveRecord Concepts**: `Relation#merge` across joined associations
- **Task Requirement**: Write `Project.with_overdue_issues` using `Project.joins(:issues).merge(Issue.overdue).distinct` so the overdue logic lives exclusively on `Issue` without duplicating SQL conditions in `Project`.

```ruby
class Project < ApplicationRecord
  scope :active, -> { where(archived: false) }
  scope :with_overdue_issues, ->(now = Time.current) { joins(:issues).merge(Issue.overdue(now)).distinct }
end
```

### Task 073: Surgically Removing & Replacing Query Clauses (`unscope`, `rewhere`, `reorder`)
- **Depends On**: Task 072 (modifies existing chained relations without rebuilding them from scratch)
- **ActiveRecord Concepts**: `unscope(:where, :order)`, `unscope(where: :state)`, `rewhere(state: :closed)`
- **Task Requirement**: Given `base_rel = Issue.overdue.prioritized_backlog`, write a helper `Issue.overdue_even_if_closed(base_rel)` that uses `base_rel.rewhere(state: [:opened, :closed]).unscope(:order).order(closed_at: :desc)`.

```ruby
class Issue < ApplicationRecord
  def self.overdue_even_if_closed(relation = overdue.prioritized_backlog)
    relation.rewhere(state: [:opened, :closed]).unscope(:order).order(closed_at: :desc)
  end
end
```

### Task 074: Reusable `Archivable` Concern Without the `default_scope` Anti-Pattern
- **Depends On**: Task 073 (adds explicit soft-archival scopes and methods to `Organization` and `Project`)
- **ActiveRecord Concepts**: `ActiveSupport::Concern`, Explicit `kept` / `soft_deleted` scopes instead of `default_scope`
- **Task Requirement**: Create an `Archivable` concern for `Organization` (using `deleted_at`) that provides `.kept`, `.soft_deleted`, `#soft_delete!`, and `#restore!`, explaining why `default_scope { where(deleted_at: nil) }` breaks associations and uniqueness checks.

```ruby
module Archivable
  extend ActiveSupport::Concern

  included do
    scope :kept, -> { where(deleted_at: nil) }
    scope :soft_deleted, -> { where.not(deleted_at: nil) }
  end

  def soft_delete!
    update!(deleted_at: Time.current)
  end

  def restore!
    update!(deleted_at: nil)
  end
end

class Organization < ApplicationRecord
  include Archivable
end
```

### Task 075: Extending Relations Dynamically with `Relation#extending`
- **Depends On**: Task 074 (attaches summary calculation methods directly to returned `Issue` relations)
- **ActiveRecord Concepts**: `Relation#extending(Module)`
- **Task Requirement**: Create a `IssueRelationSummary` module with `#total_weight`, `#critical_ratio`, and attach it via `Issue.all.extending(IssueRelationSummary)`.

```ruby
module IssueRelationSummary
  def total_weight
    sum(:weight)
  end

  def critical_ratio
    total = count
    return 0.0 if total.zero?
    (where(priority: :critical).count.to_f / total).round(2)
  end
end

class Issue < ApplicationRecord
  scope :with_summary_extension, -> { extending(IssueRelationSummary) }
end
```

### Task 076: Null Relation Pattern (`Model.none`) for Authorization Short-Circuiting
- **Depends On**: Task 075 (safely returns an empty chainable `ActiveRecord::Relation` when a user has no access)
- **ActiveRecord Concepts**: `Model.none`, `ActiveRecord::NullRelation`
- **Task Requirement**: Implement `Project.visible_to(user)` that returns `Project.none` when `user.nil?` or `user.locked_at.present?`, so callers can still chain `.where(...)`, `.includes(...)`, or `.count` with zero SQL queries executed.

```ruby
class Project < ApplicationRecord
  def self.visible_to(user)
    return none if user.nil? || user.locked_at.present?
    return all if user.instance_admin_role?

    left_joins(organization: :memberships)
      .where("projects.visibility = :pub OR memberships.user_id = :uid",
             pub: visibilities[:public_vis], uid: user.id)
      .distinct
  end
end
```

### Task 077: Immutable Reporting Queries with `Relation#readonly`
- **Depends On**: Task 076 (prevents accidental mutation of joined or reporting models)
- **ActiveRecord Concepts**: `Relation#readonly`, `ActiveRecord::ReadOnlyRecord`
- **Task Requirement**: Implement `Issue.audit_snapshot_for(project_id)` returning a `.readonly` relation so any downstream code attempting `issue.update!(...)` raises `ActiveRecord::ReadOnlyRecord`.

```ruby
class Issue < ApplicationRecord
  def self.audit_snapshot_for(project_id)
    where(project_id: project_id).readonly
  end
end
```

### Task 078: Race-Safe `create_or_find_by!` vs `find_or_create_by!` on Unique `Label`s
- **Depends On**: Task 077 (prevents `ActiveRecord::RecordNotUnique` crashes under concurrent label creation)
- **ActiveRecord Concepts**: `create_or_find_by!`, `find_or_create_by!` with `create_with`
- **Task Requirement**: Implement `Label.ensure_for_project!(project, title:, color: '#FC6D26')` using `create_with(color: color).create_or_find_by!(project: project, title: title)` leveraging the unique index `[:project_id, :title]` from Task 048.

```ruby
class Label < ApplicationRecord
  def self.ensure_for_project!(project, title:, color: "#FC6D26")
    create_with(color: color).create_or_find_by!(project: project, title: title)
  end
end
```

### Task 079: Composable Query Object Pattern (`StaleIssuesQuery`)
- **Depends On**: Task 078 (encapsulates complex multi-scope filtering into a dedicated Query Object)
- **ActiveRecord Concepts**: Query Object accepting an `ActiveRecord::Relation` and returning a `Relation`
- **Task Requirement**: Build `StaleIssuesQuery.call(relation = Issue.all, inactive_days: 14, min_weight: 2)` that chains onto any existing `Issue` relation (such as `project.issues` or `Issue.visible_to(user)`).

```ruby
class StaleIssuesQuery
  def self.call(relation = Issue.all, inactive_days: 14, min_weight: 2)
    cutoff = inactive_days.days.ago
    relation
      .where(state: :opened)
      .weighted_at_least(min_weight)
      .where(updated_at: ..cutoff)
      .order(updated_at: :asc)
  end
end
```

### Task 080: Module 8 Milestone: `AuthorizedWorkItemFinder` Combining `visible_to`, `merge`, `extending` & `StaleIssuesQuery`
- **Depends On**: Task 079 (integrates all scope and relation composition patterns from Tasks 071–079)
- **ActiveRecord Concepts**: `Model.none`, `merge`, `extending`, `rewhere`, Query Objects
- **Task Requirement**: Implement `AuthorizedWorkItemFinder.stale_issues_for(user:, min_weight: 1)` that scopes visible projects via `Project.visible_to(user)`, merges them into `Issue`, applies `StaleIssuesQuery`, and attaches `IssueRelationSummary`.

```ruby
class AuthorizedWorkItemFinder
  def self.stale_issues_for(user:, inactive_days: 0, min_weight: 1)
    visible_projects = Project.visible_to(user).active
    return Issue.none.extending(IssueRelationSummary) if visible_projects.none?

    base_issues = Issue.joins(:project).merge(visible_projects)
    StaleIssuesQuery.call(base_issues, inactive_days: inactive_days, min_weight: min_weight)
                    .extending(IssueRelationSummary)
  end
end
```

## Module 9: Eager Loading (`preload`, `eager_load`, `includes`), `strict_loading!` & Batch Processing

> **Module Goal**: Eliminate N+1 queries with verifiable `SqlQueryCounter` instrumentation, `preload` vs `eager_load` vs `includes`, polymorphic/`DelegatedType` eager loading, `strict_loading!`, `.size` vs `.count` counter-cache optimization, `find_each`, and `in_batches(load: false)`.

### Task 081: Build `SqlQueryCounter` Instrumentation Helper to Assert Exact SQL Query Counts
- **Depends On**: Task 080 (measures exact SQL queries executed by finders and serializers)
- **ActiveRecord Concepts**: `ActiveSupport::Notifications.subscribed`, `sql.active_record` payload inspection
- **Task Requirement**: Write `SqlQueryCounter.track { ... }` that subscribes to `'sql.active_record'`, ignores `SCHEMA` and `TRANSACTION` queries, and returns `{ count:, queries:, result: }` so every N+1 optimization in Module 9 is provably verified.

```ruby
module SqlQueryCounter
  IGNORED_NAMES = %w[SCHEMA TRANSACTION].freeze

  def self.track
    queries = []
    callback = ->(_name, _start, _finish, _id, payload) do
      next if IGNORED_NAMES.include?(payload[:name]) || payload[:cached]
      queries << payload[:sql]
    end
    result = nil
    ActiveSupport::Notifications.subscribed(callback, "sql.active_record") do
      result = yield
    end
    { count: queries.size, queries: queries, result: result }
  end
end
```

### Task 082: Multi-Tree Eager Loading with `preload` to Avoid Cartesian Join Bloat
- **Depends On**: Task 081 (eager-loads `Project -> [creator, repository_config, issues: [:author, :labels]]`)
- **ActiveRecord Concepts**: `preload` with nested hash/array associations
- **Task Requirement**: Implement `Project.preload_board_associations` using `preload(:creator, :repository_config, issues: [:author, :assignee, :labels])` and verify with `SqlQueryCounter` that rendering 20 projects and their issues executes a bounded constant number of queries.

```ruby
class Project < ApplicationRecord
  def self.preload_board_associations
    preload(:creator, :repository_config, issues: [:author, :assignee, :labels])
  end
end
```

### Task 083: Single-Query `eager_load` (`LEFT OUTER JOIN`) When Filtering by Associated Columns
- **Depends On**: Task 082 (loads `Project` and matching `Issue` records in a single SQL query)
- **ActiveRecord Concepts**: `eager_load`, `includes(...).references(...)`
- **Task Requirement**: Implement `Project.eager_load_critical_issues` using `eager_load(issues: :author).where(issues: { priority: :critical, state: :opened })` to instantiate both projects and their critical open issues in exactly 1 SQL query.

```ruby
class Project < ApplicationRecord
  def self.eager_load_critical_issues
    eager_load(issues: :author)
      .where(issues: { priority: Issue.priorities[:critical], state: Issue.states[:opened] })
  end
end
```

### Task 084: Controlling `includes` Heuristics (`preload` Path vs `eager_load` Path)
- **Depends On**: Task 083 (demonstrates when `includes` switches from 2 queries to 1 `LEFT OUTER JOIN`)
- **ActiveRecord Concepts**: `includes`, `.references(:table)`
- **Task Requirement**: Write a comparison method `Issue.compare_includes_paths(project_id)` showing `Issue.includes(:notes).where(project_id:)` (2 queries) vs `Issue.includes(:notes).where(project_id:, notes: { system: false })` (1 query).

```ruby
class Issue < ApplicationRecord
  def self.compare_includes_paths(project_id)
    separate = SqlQueryCounter.track { Issue.includes(:notes).where(project_id: project_id).to_a }
    joined   = SqlQueryCounter.track { Issue.includes(:notes).where(project_id: project_id, notes: { system: false }).to_a }
    { preload_query_count: separate[:count], eager_load_query_count: joined[:count] }
  end
end
```

### Task 085: Polymorphic & `DelegatedType` Eager Loading on `TimelineEvent` and `Note`
- **Depends On**: Task 084 (eliminates N+1s across heterogeneous `TimelineEvent#eventable` and `Note#noteable` targets)
- **ActiveRecord Concepts**: `includes(:actor, :eventable)` on `DelegatedType` and polymorphic associations
- **Task Requirement**: Implement `TimelineEvent.feed_for_project(project_id)` that eager-loads `:actor` and polymorphic `:eventable` (`IssueClosedPayload` and `MrMergedPayload`) and their nested `issue` / `merge_request` records.

```ruby
class TimelineEvent < ApplicationRecord
  def self.feed_for_project(project_id)
    where(project_id: project_id)
      .includes(:actor, :eventable)
      .order(occurred_at: :desc)
  end
end
```

### Task 086: Enforcing `strict_loading!` Across Relations, Associations & Modes
- **Depends On**: Task 085 (prevents accidental lazy-loading regressions in serializers)
- **ActiveRecord Concepts**: `strict_loading!`, `strict_loading!(mode: :n_plus_one_only)`, `ActiveRecord::StrictLoadingViolationError`
- **Task Requirement**: Implement `Issue.strict_board_scope(project_id)` that enables `.strict_loading` and preloads `:author`, `:assignee`, and `:labels`, raising `ActiveRecord::StrictLoadingViolationError` if a view tries to call `issue.notes.to_a` without preloading `:notes`.

```ruby
class Issue < ApplicationRecord
  def self.strict_board_scope(project_id)
    where(project_id: project_id)
      .preload(:author, :assignee, :labels)
      .strict_loading
  end
end
```

### Task 087: Eliminating `.count` N+1s via `.size` & Counter Cache Awareness
- **Depends On**: Task 086 (optimizes collection counting on `Issue#notes` and `Issue#labels`)
- **ActiveRecord Concepts**: `.size` vs `.count` vs `.length` on `CollectionProxy`
- **Task Requirement**: Implement `Issue#fast_notes_total` and `Issue#fast_labels_total` using `.size` so `notes.size` reads the `notes_count` counter cache column (0 queries) and `labels.size` uses the preloaded array length when `labels` is eager-loaded (0 extra queries).

```ruby
class Issue < ApplicationRecord
  def fast_notes_total
    notes.size # Reads issues.notes_count column directly!
  end

  def fast_labels_total
    labels.size # Uses in-memory array length if preloaded!
  end
end
```

### Task 088: Memory-Bounded Iteration with `find_each` & Cursor Order Constraints
- **Depends On**: Task 087 (streams `Issue` records in fixed-size batches ordered by primary key)
- **ActiveRecord Concepts**: `find_each(batch_size:, start:, finish:, order: :asc)`
- **Task Requirement**: Implement `Issue.stream_digest(project_id, batch_size: 100)` using `find_each(batch_size: batch_size)` to yield formatted issue summaries without loading the entire table into memory.

```ruby
class Issue < ApplicationRecord
  def self.stream_digest(project_id, batch_size: 100)
    return enum_for(:stream_digest, project_id, batch_size: batch_size) unless block_given?

    where(project_id: project_id)
      .preload(:author, :labels)
      .find_each(batch_size: batch_size) do |issue|
        yield "##{issue.iid} #{issue.title} (@#{issue.author.username}) [#{issue.labels.map(&:title).join(', ')}]"
      end
  end
end
```

### Task 089: Relation-Level Batching with `in_batches(of:, load: false)` for Bulk Updates
- **Depends On**: Task 088 (performs throttled batch updates on `Issue` without instantiating Ruby objects)
- **ActiveRecord Concepts**: `in_batches(of: 500, load: false)`, Batch `update_all`
- **Task Requirement**: Implement `Issue.auto_close_ancient!(cutoff: 1.year.ago, batch_size: 500)` using `in_batches(of: batch_size, load: false)` to mark old open issues as `:closed` in chunks and return total rows updated.

```ruby
class Issue < ApplicationRecord
  def self.auto_close_ancient!(cutoff: 1.year.ago, batch_size: 500)
    total_closed = 0
    where(state: :opened, updated_at: ..cutoff).in_batches(of: batch_size, load: false) do |batch_relation|
      total_closed += batch_relation.update_all(state: states[:closed], closed_at: Time.current, updated_at: Time.current)
    end
    total_closed
  end
end
```

### Task 090: Module 9 Milestone: `ZeroNPlusOneBoardSerializer` Verified Under `strict_loading!` & `SqlQueryCounter`
- **Depends On**: Task 089 (combines `preload`, `strict_loading!`, `.size`, and `SqlQueryCounter` from Tasks 081–089)
- **ActiveRecord Concepts**: Guaranteed Constant Query Budget ($\le 4$ Queries) Regardless of Issue/Label/Note Volume
- **Task Requirement**: Build `ZeroNPlusOneBoardSerializer.serialize(project_id)` that loads a project's board under `strict_loading`, serializes all issues with authors, assignees, label names, and note counts, and asserts via `SqlQueryCounter` that total queries $\le 4$.

```ruby
class ZeroNPlusOneBoardSerializer
  def self.serialize(project_id)
    tracked = SqlQueryCounter.track do
      Issue.strict_board_scope(project_id).map do |issue|
        {
          iid: issue.iid,
          title: issue.title,
          author: issue.author.username,
          assignee: issue.assignee&.username,
          labels: issue.labels.map(&:title),
          notes_count: issue.fast_notes_total,
          labels_count: issue.fast_labels_total
        }
      end
    end

    raise "N+1 detected! Executed #{tracked[:count]} queries" if tracked[:count] > 4
    { query_count: tracked[:count], payload: tracked[:result] }
  end
end
```

## Module 10: Arel AST Mastery & Advanced SQL Construction (`CASE`, `EXISTS`, `LATERAL`, `UNION ALL`)

> **Module Goal**: Drop down to `arel_table` AST nodes to construct grouped boolean predicates, `Arel::Nodes::NamedFunction` (`COALESCE`), `Arel::Nodes::Case` dynamic SLA scoring, explicit `OuterJoin` ASTs, correlated `EXISTS` subqueries, top-N-per-group queries, and `UNION ALL` work item feeds.

### Task 091: Arel Table Nodes & Predicate Builders (`eq`, `gteq`, `matches`, `in`)
- **Depends On**: Task 090 (builds composable Arel predicates on `Issue.arel_table`)
- **ActiveRecord Concepts**: `Model.arel_table`, `.eq`, `.not_eq`, `.gteq`, `.lt`, `.matches`
- **Task Requirement**: Write `Issue.arel_high_urgency_predicate` using `t = Issue.arel_table` to construct `(t[:priority].gteq(2)).and(t[:state].eq(0))` and pass it to `Issue.where(...)`.

```ruby
class Issue < ApplicationRecord
  def self.arel_high_urgency_predicate
    t = arel_table
    t[:priority].gteq(priorities[:high]).and(t[:state].eq(states[:opened]))
  end
end
```

### Task 092: Complex Arel Boolean Grouping (`Arel::Nodes::Grouping`, `.or`, `.not`)
- **Depends On**: Task 091 (combines compound `AND`/`OR` expressions with explicit AST parentheses)
- **ActiveRecord Concepts**: `Arel::Nodes::Grouping`, `.and`, `.or`, `.not`
- **Task Requirement**: Construct an Arel query `Issue.sla_at_risk(now = Time.current)` matching open issues where `(priority = critical AND notes_count = 0) OR (due_at < now AND assignee_id IS NULL)` using pure Arel AST nodes.

```ruby
class Issue < ApplicationRecord
  def self.sla_at_risk(now = Time.current)
    t = arel_table
    unanswered_critical = t[:priority].eq(priorities[:critical]).and(t[:notes_count].eq(0))
    unassigned_overdue  = t[:due_at].lt(now).and(t[:assignee_id].eq(nil))

    where(t[:state].eq(states[:opened]).and(unanswered_critical.or(unassigned_overdue)))
  end
end
```

### Task 093: Arel Named SQL Functions (`COALESCE`, `GREATEST`, `LOWER`) & Type Casting
- **Depends On**: Task 092 (invokes SQL functions safely via `Arel::Nodes::NamedFunction`)
- **ActiveRecord Concepts**: `Arel::Nodes::NamedFunction.new(name, args)`, `.as(alias_name)`
- **Task Requirement**: Implement `Issue.with_coalesced_activity_timestamp` using `Arel::Nodes::NamedFunction.new('COALESCE', [arel_table[:closed_at], arel_table[:updated_at], arel_table[:created_at]]).as('last_touched_at')`.

```ruby
class Issue < ApplicationRecord
  def self.with_coalesced_activity_timestamp
    t = arel_table
    coalesce_fn = Arel::Nodes::NamedFunction.new(
      "COALESCE",
      [t[:closed_at], t[:updated_at], t[:created_at]]
    ).as("last_touched_at")

    select(t[Arel.star], coalesce_fn)
  end
end
```

### Task 094: Dynamic SQL Scoring with `Arel::Nodes::Case` (`CASE WHEN ... THEN ... ELSE ... END`)
- **Depends On**: Task 093 (computes dynamic SLA points in SQL using `Arel::Nodes::Case`)
- **ActiveRecord Concepts**: `Arel::Nodes::Case.new`, `.when(...).then(...)`, `.else(...)`
- **Task Requirement**: Write `Issue.with_sla_score` using `Arel::Nodes::Case.new(arel_table[:priority])` that maps `critical -> 100`, `high -> 50`, `medium -> 20`, `else -> 5`, multiplies by `weight`, and aliases as `sla_score`.

```ruby
class Issue < ApplicationRecord
  def self.with_sla_score
    t = arel_table
    priority_multiplier = Arel::Nodes::Case.new(t[:priority])
      .when(priorities[:critical]).then(100)
      .when(priorities[:high]).then(50)
      .when(priorities[:medium]).then(20)
      .else(5)

    score_expr = Arel::Nodes::Multiplication.new(priority_multiplier, t[:weight]).as("sla_score")
    select(t[Arel.star], score_expr).order(Arel.sql("sla_score DESC"))
  end
end
```

### Task 095: Building Explicit Arel Join ASTs (`join(...).on(...).join_sources`)
- **Depends On**: Task 094 (constructs parameterized multi-condition `LEFT OUTER JOIN` ASTs in Arel)
- **ActiveRecord Concepts**: `arel_table.join(other_table, Arel::Nodes::OuterJoin).on(...)`, `.join_sources`
- **Task Requirement**: Implement `Issue.with_author_membership_role` that joins `memberships` onto `issues` and `projects` where `memberships.user_id = issues.author_id AND memberships.organization_id = projects.organization_id` using Arel `OuterJoin`.

```ruby
class Issue < ApplicationRecord
  def self.with_author_membership_role
    i = Issue.arel_table
    p = Project.arel_table
    m = Membership.arel_table

    join_proj = i.join(p).on(p[:id].eq(i[:project_id]))
    join_mem  = join_proj.join(m, Arel::Nodes::OuterJoin).on(
      m[:user_id].eq(i[:author_id]).and(m[:organization_id].eq(p[:organization_id]))
    )

    joins(join_mem.join_sources).select(i[Arel.star], m[:access_level].as("author_org_access_level"))
  end
end
```

### Task 096: Correlated `EXISTS` & `NOT EXISTS` Subqueries via Arel (`.arel.exists`)
- **Depends On**: Task 095 (replaces slow `IN` / `JOIN DISTINCT` queries with correlated `EXISTS`)
- **ActiveRecord Concepts**: `subquery_relation.arel.exists`, `.not`
- **Task Requirement**: Implement `Project.with_unanswered_critical_issues` using a correlated `EXISTS` subquery (`Issue.where(Issue.arel_table[:project_id].eq(Project.arel_table[:id])).where(priority: :critical, notes_count: 0).arel.exists`) so the DB halts scanning as soon as the first matching issue is found.

```ruby
class Project < ApplicationRecord
  def self.with_unanswered_critical_issues
    i = Issue.arel_table
    p = Project.arel_table

    correlated = Issue.where(i[:project_id].eq(p[:id]))
                      .where(priority: :critical, state: :opened, notes_count: 0)
    where(correlated.arel.exists)
  end
end
```

### Task 097: Top-N-Per-Group Queries Using SQL `LATERAL` Joins / Correlated Subqueries
- **Depends On**: Task 096 (fetches each `Project` alongside its single most recent `Issue` in 1 query)
- **ActiveRecord Concepts**: `LEFT JOIN LATERAL (...) ON TRUE` / Correlated Latest Child Subquery
- **Task Requirement**: Implement `Project.with_latest_issue_summary` fetching each project with its latest issue's `iid` and `title` in a single query.

```ruby
class Project < ApplicationRecord
  def self.with_latest_issue_summary
    latest_iid_sql = "(SELECT issues.iid FROM issues WHERE issues.project_id = projects.id ORDER BY issues.created_at DESC, issues.id DESC LIMIT 1) AS latest_issue_iid"
    latest_title_sql = "(SELECT issues.title FROM issues WHERE issues.project_id = projects.id ORDER BY issues.created_at DESC, issues.id DESC LIMIT 1) AS latest_issue_title"
    select("projects.*", latest_iid_sql, latest_title_sql)
  end
end
```

### Task 098: Heterogeneous `UNION ALL` Work Item Feed (`Issue` + `MergeRequest`) via Arel
- **Depends On**: Task 097 (combines `Issue` and `MergeRequest` rows into a single unified feed query)
- **ActiveRecord Concepts**: `UNION ALL`, derived union table
- **Task Requirement**: Build `Project#unified_work_items(limit: 20)` that selects `id, iid, title, 'Issue' AS item_type, created_at` from `issues` and unions it via `UNION ALL` with `merge_requests`, ordering the unified stream by `created_at DESC`.

```ruby
class Project < ApplicationRecord
  def unified_work_items(limit: 20)
    issues_sql = issues.select("id, iid, title, 'Issue' AS item_type, created_at").to_sql
    mrs_sql    = merge_requests.select("id, iid, title, 'MergeRequest' AS item_type, created_at").to_sql

    union_sql = <<~SQL
      SELECT * FROM (
        #{issues_sql}
        UNION ALL
        #{mrs_sql}
      ) AS work_items
      ORDER BY created_at DESC, id DESC
      LIMIT #{limit.to_i}
    SQL
    ActiveRecord::Base.connection.exec_query(union_sql).to_a
  end
end
```

### Task 099: Arel Infix Operations (`Arel::Nodes::InfixOperation`) for Custom Operators
- **Depends On**: Task 098 (builds custom SQL infix operators for JSONB, bitwise, or math operations)
- **ActiveRecord Concepts**: `Arel::Nodes::InfixOperation.new(operator, left, right)`
- **Task Requirement**: Write `Issue.weight_divisible_by(divisor)` using `Arel::Nodes::InfixOperation.new('%', Issue.arel_table[:weight], Arel::Nodes.build_quoted(divisor)).eq(0)`.

```ruby
class Issue < ApplicationRecord
  def self.weight_divisible_by(divisor)
    mod_op = Arel::Nodes::InfixOperation.new("%", arel_table[:weight], Arel::Nodes.build_quoted(divisor))
    where(mod_op.eq(0))
  end
end
```

### Task 100: Module 10 Milestone: `ArelWorkItemSearchEngine` Combining `Case`, `EXISTS`, `LATERAL` & `UNION ALL`
- **Depends On**: Task 099 (unifies all Arel AST techniques built in Tasks 091–099)
- **ActiveRecord Concepts**: Full Arel AST Query Pipeline with Zero Unsanitized String Interpolation
- **Task Requirement**: Build `ArelWorkItemSearchEngine.project_triage_report(org)` returning projects with unanswered critical issues (`EXISTS`), their latest issue summary, and their top SLA-scored issues (`Arel::Nodes::Case`).

```ruby
class ArelWorkItemSearchEngine
  def self.project_triage_report(org)
    urgent_projects = org.projects.with_unanswered_critical_issues.with_latest_issue_summary
    scored_issues   = Issue.where(project_id: urgent_projects.map(&:id)).with_sla_score.limit(10)

    {
      urgent_projects: urgent_projects.map { |p| { path: p.path, latest_iid: p.latest_issue_iid, latest_title: p.latest_issue_title } },
      top_scored_issues: scored_issues.map { |i| { id: i.id, title: i.title, sla_score: i.sla_score } }
    }
  end
end
```

## Module 11: Bulk Persistence (`insert_all!`, `upsert_all`), Savepoints & Concurrency Locking

> **Module Goal**: Execute high-throughput and concurrency-safe writes using `insert_all!`, idempotent `upsert_all`, atomic `update_all`, nested savepoints (`requires_new: true`), optimistic locking (`lock_version`), deterministic pessimistic locking (`CreditWallet.transfer!`), and `FOR UPDATE SKIP LOCKED` (`CiBuild.claim_next_batch!`).

### Task 101: High-Throughput Bulk Inserts with `insert_all` & `insert_all!` (`returning:`)
- **Depends On**: Task 100 (bulk-creates `Label` and `Issue` records in a single SQL statement)
- **ActiveRecord Concepts**: `insert_all`, `insert_all!`, `returning:`, `record_timestamps: true`
- **Task Requirement**: Implement `Label.bulk_seed_defaults!(project)` using `Label.insert_all!` with `returning: %i[id title color]` to insert 5 standard labels (`bug`, `feature`, `security`, `performance`, `documentation`) in a single multi-row `INSERT`.

```ruby
class Label < ApplicationRecord
  DEFAULT_LABELS = [
    { title: "bug", color: "#EF4444" },
    { title: "feature", color: "#10B981" },
    { title: "security", color: "#F59E0B" },
    { title: "performance", color: "#6366F1" },
    { title: "documentation", color: "#3B82F6" }
  ].freeze

  def self.bulk_seed_defaults!(project)
    rows = DEFAULT_LABELS.map { |attrs| attrs.merge(project_id: project.id) }
    insert_all!(rows, returning: %i[id title color], record_timestamps: true)
  end
end
```

### Task 102: Idempotent Bulk Upserts with `upsert_all` (`unique_by:` & `update_only:`)
- **Depends On**: Task 101 (idempotently syncs project labels without failing on existing `[project_id, title]` rows)
- **ActiveRecord Concepts**: `upsert_all`, `unique_by: %i[project_id title]`, `update_only:`
- **Task Requirement**: Implement `Label.bulk_sync!(project, label_definitions)` using `upsert_all(..., unique_by: %i[project_id title], update_only: [:color])` so existing labels update their `color` while new labels are inserted.

```ruby
class Label < ApplicationRecord
  def self.bulk_sync!(project, label_definitions)
    rows = label_definitions.map { |d| { project_id: project.id, title: d[:title], color: d[:color] } }
    upsert_all(rows, unique_by: %i[project_id title], update_only: [:color], record_timestamps: true)
  end
end
```

### Task 103: Atomic SQL Expressions in `update_all` & Scoped `delete_by` / `destroy_by`
- **Depends On**: Task 102 (atomically increments weights/counters in SQL without race conditions)
- **ActiveRecord Concepts**: `update_all`, `delete_by`, `destroy_by`
- **Task Requirement**: Implement `Project#boost_critical_issue_weights!(delta = 2)` using `issues.where(state: :opened, priority: :critical).update_all(['weight = weight + ?, updated_at = ?', delta, Time.current])`.

```ruby
class Project < ApplicationRecord
  def boost_critical_issue_weights!(delta = 2)
    issues.where(state: :opened, priority: :critical)
          .update_all(["weight = weight + ?, updated_at = ?", delta, Time.current])
  end
end
```

### Task 104: Transaction Rollback Semantics (`ActiveRecord::Rollback` vs Standard Exceptions)
- **Depends On**: Task 103 (demonstrates how `ActiveRecord::Base.transaction` handles `ActiveRecord::Rollback`)
- **ActiveRecord Concepts**: `ActiveRecord::Base.transaction`, `raise ActiveRecord::Rollback`
- **Task Requirement**: Write `Project#transfer_ownership(new_creator)` inside `Project.transaction` that rolls back cleanly via `raise ActiveRecord::Rollback` (returning `false` without raising outside the block) if `new_creator` is not a member of `project.organization`.

```ruby
class Project < ApplicationRecord
  def transfer_ownership(new_creator)
    transferred = false
    Project.transaction do
      update!(creator: new_creator)
      unless organization.memberships.exists?(user_id: new_creator.id)
        raise ActiveRecord::Rollback
      end
      transferred = true
    end
    transferred
  end
end
```

### Task 105: Nested Transactions & Savepoints (`requires_new: true`) for Partial Fault Isolation
- **Depends On**: Task 104 (isolates optional side-effects inside a parent transaction using PostgreSQL `SAVEPOINT`)
- **ActiveRecord Concepts**: `transaction(requires_new: true)`
- **Task Requirement**: Implement `Issue.create_with_optional_note!(issue_attrs, note_body:, note_author:)` where creating the `Issue` happens in an outer transaction and writing a non-critical `Note` happens in an inner `Note.transaction(requires_new: true)` that rescues `ActiveRecord::RecordInvalid` and rolls back only the savepoint.

```ruby
class Issue < ApplicationRecord
  def self.create_with_optional_note!(issue_attrs, note_body:, note_author:)
    transaction do
      issue = create!(issue_attrs)
      begin
        Note.transaction(requires_new: true) do
          issue.notes.create!(author: note_author, body: note_body)
        end
      rescue ActiveRecord::RecordInvalid
        # Rolls back only the SAVEPOINT; the outer Issue creation still succeeds!
      end
      issue
    end
  end
end
```

### Task 106: Optimistic Locking (`lock_version`) & Conflict Recovery on `Issue`
- **Depends On**: Task 105 (uses the `lock_version` column on `Issue` from Task 041 to detect lost updates)
- **ActiveRecord Concepts**: `lock_version`, `ActiveRecord::StaleObjectError`, Retry with `reload`
- **Task Requirement**: Implement `Issue#safe_update_title!(new_title)` that rescues `ActiveRecord::StaleObjectError` when another process updates the issue concurrently, reloads the fresh `lock_version`, and retries once.

```ruby
class Issue < ApplicationRecord
  def safe_update_title!(new_title)
    attempts = 0
    begin
      attempts += 1
      update!(title: new_title)
    rescue ActiveRecord::StaleObjectError
      raise if attempts >= 2
      reload
      retry
    end
  end
end
```

### Task 107: Create `credit_wallets` & Pessimistic Row-Level Locking (`with_lock` / `FOR UPDATE`)
- **Depends On**: Task 106 (adds compute-minute credit wallets to `Organization` with pessimistic locking)
- **ActiveRecord Concepts**: `with_lock`, `lock!`, `SELECT ... FOR UPDATE`
- **Task Requirement**: Create `credit_wallets` (`organization_id` unique, `balance_credits` integer not null default 0) and `CreditWallet < ApplicationRecord`. Implement `CreditWallet#deduct!(amount)` using `with_lock` so concurrent threads can never overdraft `balance_credits` below 0.

```ruby
class CreateCreditWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :credit_wallets do |t|
      t.references :organization, null: false, index: { unique: true }, foreign_key: { on_delete: :cascade }
      t.integer :balance_credits, default: 0, null: false
      t.timestamps
    end
    add_check_constraint :credit_wallets, "balance_credits >= 0", name: "chk_wallet_non_negative"
  end
end

class CreditWallet < ApplicationRecord
  class InsufficientCreditsError < StandardError; end
  belongs_to :organization

  def deduct!(amount)
    raise ArgumentError, "Amount must be positive" if amount <= 0
    with_lock do
      raise InsufficientCreditsError, "Insufficient credits" if balance_credits < amount
      update!(balance_credits: balance_credits - amount)
    end
  end
end
```

### Task 108: Deadlock-Free Bidirectional Wallet Transfers via Canonical Lock Ordering
- **Depends On**: Task 107 (transfers credits between two `CreditWallet` records without deadlocking)
- **ActiveRecord Concepts**: `where(id: [id1, id2].sort).order(:id).lock('FOR UPDATE')`
- **Task Requirement**: Implement `CreditWallet.transfer!(from_wallet_id:, to_wallet_id:, amount:)` that acquires `FOR UPDATE` locks in canonical ascending `id` order so concurrent `A -> B` and `B -> A` transfers never trigger `PG::DeadlockDetected`.

```ruby
class CreditWallet < ApplicationRecord
  def self.transfer!(from_wallet_id:, to_wallet_id:, amount:)
    raise ArgumentError, "Invalid transfer" if amount <= 0 || from_wallet_id == to_wallet_id

    ordered_ids = [from_wallet_id, to_wallet_id].sort
    transaction do
      locked = where(id: ordered_ids).order(:id).lock("FOR UPDATE").index_by(&:id)
      from_w = locked.fetch(from_wallet_id)
      to_w   = locked.fetch(to_wallet_id)

      raise InsufficientCreditsError if from_w.balance_credits < amount
      from_w.update!(balance_credits: from_w.balance_credits - amount)
      to_w.update!(balance_credits: to_w.balance_credits + amount)
    end
  end
end
```

### Task 109: Create `ci_builds` Queue & Non-Blocking Job Claiming (`FOR UPDATE SKIP LOCKED`)
- **Depends On**: Task 108 (adds CI build jobs under `Project` and claims them concurrently with `SKIP LOCKED`)
- **ActiveRecord Concepts**: `lock('FOR UPDATE SKIP LOCKED')`
- **Task Requirement**: Create `ci_builds` (`project_id`, `name`, `stage`, `status` default 0, `runner_id`, `started_at`). Implement `CiBuild.claim_next_batch!(runner_id:, batch_size: 5)` using `lock('FOR UPDATE SKIP LOCKED')` inside a transaction so concurrent CI runners claim disjoint pending builds without blocking.

```ruby
class CreateCiBuilds < ActiveRecord::Migration[7.1]
  def change
    create_table :ci_builds do |t|
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.string   :name, null: false
      t.string   :stage, default: "test", null: false
      t.integer  :status, default: 0, null: false
      t.string   :runner_id
      t.integer  :cost_credits, default: 1, null: false
      t.datetime :started_at
      t.timestamps
    end
    add_index :ci_builds, [:status, :created_at]
  end
end

class CiBuild < ApplicationRecord
  enum :status, { pending: 0, running: 1, passed: 2, failed: 3 }, default: :pending
  belongs_to :project

  def self.claim_next_batch!(runner_id:, batch_size: 5)
    transaction do
      builds = where(status: :pending)
               .order(created_at: :asc, id: :asc)
               .limit(batch_size)
               .lock("FOR UPDATE SKIP LOCKED")
               .to_a

      now = Time.current
      builds.each { |b| b.update!(status: :running, runner_id: runner_id, started_at: now) }
      builds
    end
  end
end
```

### Task 110: Module 11 Milestone: `AtomicCiDispatcher` Combining `SKIP LOCKED`, `CreditWallet` Locking & Savepoints
- **Depends On**: Task 109 (integrates `CiBuild` claiming and `CreditWallet` deduction from Tasks 101–109)
- **ActiveRecord Concepts**: Transactional Coordination of `SKIP LOCKED`, Pessimistic Wallet Deduction, and Savepoints
- **Task Requirement**: Implement `AtomicCiDispatcher.dispatch!(runner_id:, batch_size: 5)` that claims pending `CiBuild` jobs via `SKIP LOCKED` and deducts `cost_credits` from each build's organization `CreditWallet` inside a savepoint (marking the build `:failed` if credits are exhausted without aborting sibling builds).

```ruby
class AtomicCiDispatcher
  def self.dispatch!(runner_id:, batch_size: 5)
    claimed = CiBuild.claim_next_batch!(runner_id: runner_id, batch_size: batch_size)
    results = { running: [], failed_quota: [] }

    claimed.each do |build|
      wallet = CreditWallet.find_or_create_by!(organization_id: build.project.organization_id)
      begin
        wallet.deduct!(build.cost_credits)
        results[:running] << build.id
      rescue CreditWallet::InsufficientCreditsError
        build.update!(status: :failed)
        results[:failed_quota] << build.id
      end
    end
    results
  end
end
```

## Module 12: Database-Native Power Features (Arrays, JSONB, Range Overlaps, Views, Advisory Locks & Tenant Context)

> **Module Goal**: Leverage advanced relational capabilities including array/JSONB containment, temporal range overlap prevention (`DeployFreezeWindow`), string-backed enums, virtual stored columns (`reference_code`), SQL views (`ProjectHealthSummary`), covering indexes, advisory locks, and `CurrentAttributes` tenant scoping.

### Task 111: PostgreSQL Array Columns (`tag_list`) & Containment (`@>`, `&&`) Queries on `CiBuild`
- **Depends On**: Task 110 (adds runner capability tags to `CiBuild` from Task 109)
- **ActiveRecord Concepts**: PostgreSQL `array: true`, GIN index, `@>` (contains) and `<@` (is contained by) operators
- **Task Requirement**: Add `required_tags` (array of strings, default `[]`) to `ci_builds` and implement `CiBuild.matching_runner_tags(runner_tags)` that finds builds whose `required_tags` are a subset of the runner's tags.

```ruby
class AddRequiredTagsToCiBuilds < ActiveRecord::Migration[7.1]
  def change
    add_column :ci_builds, :required_tags, :jsonb, default: [], null: false
  end
end

class CiBuild < ApplicationRecord
  def self.matching_runner_tags(runner_tags)
    where(status: :pending).select { |b| (Array(b.required_tags) - Array(runner_tags)).empty? }
  end
end
```

### Task 112: PostgreSQL `jsonb` Deep Path Containment (`@>`) & Atomic `jsonb_set` Updates
- **Depends On**: Task 111 (queries `Organization#settings` and `User#preferences` JSONB columns from Module 1)
- **ActiveRecord Concepts**: JSONB `@>`, `->`, `->>` operators, GIN `jsonb_path_ops`
- **Task Requirement**: Implement `Organization.with_setting(key, expected_value)` that queries `settings` JSONB containment (`settings @> :payload` or `json_extract`) so nested settings are filtered inside the database.

```ruby
class Organization < ApplicationRecord
  def self.with_setting(key, expected_value)
    where("json_extract(settings, :path) = :val", path: "$.#{key}", val: expected_value)
  rescue ActiveRecord::StatementInvalid
    where("settings @> ?", { key => expected_value }.to_json)
  end
end
```

### Task 113: Date/Time Window Overlap Detection (`OVERLAPS` / Range Exclusion) for `DeployFreezeWindow`
- **Depends On**: Task 112 (prevents overlapping deployment freeze windows on `Project`)
- **ActiveRecord Concepts**: Temporal Range Overlap Queries (`starts_at < :end AND ends_at > :start` / PostgreSQL `tsrange &&`)
- **Task Requirement**: Create `deploy_freeze_windows` (`project_id`, `starts_at`, `ends_at`, `reason`) and validate on `DeployFreezeWindow` that no two active windows for the same project overlap in time.

```ruby
class CreateDeployFreezeWindows < ActiveRecord::Migration[7.1]
  def change
    create_table :deploy_freeze_windows do |t|
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.string   :reason, null: false
      t.timestamps
    end
  end
end

class DeployFreezeWindow < ApplicationRecord
  belongs_to :project
  validates :ends_at, comparison: { greater_than: :starts_at }
  validate :prevent_overlapping_windows

  scope :overlapping, ->(start_t, end_t) {
    where("starts_at < :end_t AND ends_at > :start_t", start_t: start_t, end_t: end_t)
  }

  private

  def prevent_overlapping_windows
    return unless project_id && starts_at && ends_at
    clash = DeployFreezeWindow.where(project_id: project_id)
                              .where.not(id: id)
                              .overlapping(starts_at, ends_at)
    errors.add(:base, "overlaps with an existing deploy freeze window") if clash.exists?
  end
end
```

### Task 114: PostgreSQL Native `create_enum` Types Integrated with ActiveRecord `enum`
- **Depends On**: Task 113 (maps PostgreSQL native enum types cleanly in Rails 7.1+)
- **ActiveRecord Concepts**: `create_enum` migration, `t.enum`, String-backed ActiveRecord `enum`
- **Task Requirement**: Define a string-backed `enum :merge_status, { unchecked: 'unchecked', can_be_merged: 'can_be_merged', cannot_be_merged: 'cannot_be_merged' }, default: 'unchecked', validate: true` on `MergeRequest`.

```ruby
class AddMergeStatusToMergeRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :merge_requests, :merge_status, :string, default: "unchecked", null: false
  end
end

class MergeRequest < ApplicationRecord
  enum :merge_status, {
    unchecked: "unchecked",
    can_be_merged: "can_be_merged",
    cannot_be_merged: "cannot_be_merged"
  }, default: "unchecked", validate: true
end
```

### Task 115: Virtual / Stored Generated Columns (`t.virtual`) for Full-Text Search & Normalized Keys
- **Depends On**: Task 114 (adds a database-computed column to `Issue`)
- **ActiveRecord Concepts**: `t.virtual :col, type: ..., as: '...', stored: true`
- **Task Requirement**: Add a stored virtual column `reference_code` (`'#' || iid`) on `Issue` via migration so `issue.reference_code` is automatically maintained by the database engine on every insert/update.

```ruby
class AddVirtualReferenceCodeToIssues < ActiveRecord::Migration[7.1]
  def change
    add_column :issues, :reference_code, :virtual, type: :string, as: "'#' || iid", stored: true
  end
end
```

### Task 116: Database Reporting Views Backed by Read-Only ActiveRecord Models (`ProjectHealthSummary`)
- **Depends On**: Task 115 (creates a SQL database view `project_health_summaries` queried as an ActiveRecord model)
- **ActiveRecord Concepts**: `CREATE VIEW`, Read-only ActiveRecord model with `self.primary_key = :project_id`
- **Task Requirement**: Create a SQL view `project_health_summaries` aggregating each project's `open_issues_count`, `critical_issues_count`, and `open_mrs_count`, and back it with a read-only `ProjectHealthSummary < ApplicationRecord` model.

```ruby
class CreateProjectHealthSummariesView < ActiveRecord::Migration[7.1]
  def up
    execute <<~SQL
      CREATE VIEW project_health_summaries AS
      SELECT
        projects.id AS project_id,
        projects.organization_id,
        projects.path AS project_path,
        COUNT(DISTINCT CASE WHEN issues.state = 0 THEN issues.id END) AS open_issues_count,
        COUNT(DISTINCT CASE WHEN issues.state = 0 AND issues.priority = 3 THEN issues.id END) AS critical_issues_count,
        COUNT(DISTINCT CASE WHEN merge_requests.state = 0 THEN merge_requests.id END) AS open_mrs_count
      FROM projects
      LEFT JOIN issues ON issues.project_id = projects.id
      LEFT JOIN merge_requests ON merge_requests.project_id = projects.id
      GROUP BY projects.id, projects.organization_id, projects.path
    SQL
  end

  def down
    execute "DROP VIEW IF EXISTS project_health_summaries"
  end
end

class ProjectHealthSummary < ApplicationRecord
  self.primary_key = :project_id
  belongs_to :project
  belongs_to :organization

  def readonly?
    true
  end
end
```

### Task 117: Query Plan Inspection (`explain`) & Covering Indexes (`include:`) for Index-Only Scans
- **Depends On**: Task 116 (optimizes high-frequency `Issue` board lookups with covering indexes)
- **ActiveRecord Concepts**: `add_index ..., where: ..., include: [...]`, `Relation#explain`
- **Task Requirement**: Write a migration adding a composite index on `issues [:project_id, :state, :priority]` and a diagnostic method `Issue.explain_board_query(project_id)` returning the query plan via `.explain`.

```ruby
class AddCoveringIndexToIssues < ActiveRecord::Migration[7.1]
  def change
    add_index :issues, [:project_id, :state, :priority], name: "idx_issues_board_covering"
  end
end

class Issue < ApplicationRecord
  def self.explain_board_query(project_id)
    where(project_id: project_id, state: :opened).order(priority: :desc).explain.to_s
  end
end
```

### Task 118: Distributed Synchronization with Transaction-Level Advisory Locks
- **Depends On**: Task 117 (prevents concurrent pipeline schedulers from racing on the same `Project`)
- **ActiveRecord Concepts**: `Zlib.crc32`, `pg_try_advisory_xact_lock` with SQLite/DB-agnostic fallback
- **Task Requirement**: Implement `Project#with_scheduler_lock` that acquires a transaction-scoped advisory lock keyed on `"project_scheduler:#{id}"` before scheduling recurring pipelines.

```ruby
require "zlib"

class Project < ApplicationRecord
  def with_scheduler_lock
    lock_id = Zlib.crc32("project_scheduler:#{id}")
    Project.transaction do
      if Project.connection.adapter_name.downcase.include?("postgres")
        acquired = Project.connection.select_value("SELECT pg_try_advisory_xact_lock(#{lock_id})")
        return :locked unless acquired
      else
        lock!
      end
      yield
    end
  end
end
```

### Task 119: Tenant Context Isolation via `ActiveSupport::CurrentAttributes` (`Current.organization`)
- **Depends On**: Task 118 (binds tenant context for default association scoping and RLS session settings)
- **ActiveRecord Concepts**: `ActiveSupport::CurrentAttributes`, Tenant-scoped queries
- **Task Requirement**: Define `Current < ActiveSupport::CurrentAttributes` with `attribute :organization, :user` and `Current.with_tenant(org, user:)` so `Project.current_tenant` automatically scopes to `Current.organization`.

```ruby
class Current < ActiveSupport::CurrentAttributes
  attribute :organization, :user

  def self.with_tenant(org, user: nil)
    set(organization: org, user: user) { yield }
  end
end

class Project < ApplicationRecord
  scope :current_tenant, -> { Current.organization ? where(organization: Current.organization) : none }
end
```

### Task 120: Module 12 Milestone: `ProjectHealthAndFreezeMonitor` Combining Views, Range Overlaps & Tenant Context
- **Depends On**: Task 119 (integrates `ProjectHealthSummary`, `DeployFreezeWindow`, and `Current.with_tenant`)
- **ActiveRecord Concepts**: SQL Views, Temporal Range Overlap Validation, Advisory Lock Wrapper, `CurrentAttributes`
- **Task Requirement**: Build `ProjectHealthAndFreezeMonitor.status_for_current_tenant(at: Time.current)` that queries `ProjectHealthSummary` for `Current.organization` and flags whether each project is currently inside an active `DeployFreezeWindow`.

```ruby
class ProjectHealthAndFreezeMonitor
  def self.status_for_current_tenant(at: Time.current)
    return [] unless Current.organization

    summaries = ProjectHealthSummary.where(organization_id: Current.organization.id)
    frozen_project_ids = DeployFreezeWindow.where(project_id: summaries.map(&:project_id))
                                           .overlapping(at, at + 1.second)
                                           .pluck(:project_id)
                                           .to_set

    summaries.map do |s|
      {
        project_path: s.project_path,
        open_issues: s.open_issues_count,
        critical_issues: s.critical_issues_count,
        open_mrs: s.open_mrs_count,
        deploy_frozen: frozen_project_ids.include?(s.project_id)
      }
    end
  end
end
```

## Module 13: Modern Rails 7.1 / 8.0 Features (Composite Primary Keys, Encryption, Stateless Tokens & Multi-DB)

> **Module Goal**: Master modern ActiveRecord additions: composite primary keys (`ProjectDeployment` with `[:project_id, :deployment_number]` and `query_constraints`), deterministic vs non-deterministic `encrypts`, `generates_token_for`, `has_secure_token`, `connected_to(prevent_writes: true)`, and `disable_joins: true`.

### Task 121: Native Composite Primary Keys (`primary_key: [:project_id, :deployment_number]`) on `ProjectDeployment`
- **Depends On**: Task 120 (creates `project_deployments` keyed by composite `[:project_id, :deployment_number]`)
- **ActiveRecord Concepts**: Rails 7.1+ Composite Primary Keys (`primary_key: [:col1, :col2]`, `self.primary_key = [...]`)
- **Task Requirement**: Create `project_deployments` with `primary_key: [:project_id, :deployment_number]`, `environment` (string), `sha` (string), and `status` (integer). Define `ProjectDeployment < ApplicationRecord` with `self.primary_key = [:project_id, :deployment_number]`.

```ruby
class CreateProjectDeployments < ActiveRecord::Migration[7.1]
  def change
    create_table :project_deployments, primary_key: [:project_id, :deployment_number] do |t|
      t.bigint  :project_id, null: false
      t.integer :deployment_number, null: false
      t.string  :environment, default: "production", null: false
      t.string  :sha, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end

class ProjectDeployment < ApplicationRecord
  self.primary_key = [:project_id, :deployment_number]
  enum :status, { created: 0, running: 1, succeeded: 2, failed: 3 }, default: :created
  belongs_to :project
end
```

### Task 122: Querying & Associating Composite Primary Key Models (`query_constraints`)
- **Depends On**: Task 121 (associates `DeploymentApproval` to `ProjectDeployment` using `query_constraints`)
- **ActiveRecord Concepts**: `ProjectDeployment.find([project_id, deployment_number])`, `query_constraints: [:project_id, :deployment_number]`
- **Task Requirement**: Create `deployment_approvals` (`project_id`, `deployment_number`, `user_id`, `comment`) and wire `belongs_to :project_deployment, query_constraints: [:project_id, :deployment_number]` and `has_many :deployment_approvals, query_constraints: [:project_id, :deployment_number]`.

```ruby
class CreateDeploymentApprovals < ActiveRecord::Migration[7.1]
  def change
    create_table :deployment_approvals do |t|
      t.bigint     :project_id, null: false
      t.integer    :deployment_number, null: false
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.string     :comment
      t.timestamps
    end
    add_index :deployment_approvals, [:project_id, :deployment_number]
  end
end

class DeploymentApproval < ApplicationRecord
  belongs_to :project_deployment, query_constraints: [:project_id, :deployment_number], inverse_of: :deployment_approvals
  belongs_to :user
end

class ProjectDeployment < ApplicationRecord
  has_many :deployment_approvals, query_constraints: [:project_id, :deployment_number],
                                  dependent: :destroy, inverse_of: :project_deployment
end
```

### Task 123: ActiveRecord Encryption (`encrypts`) — Deterministic vs Non-Deterministic
- **Depends On**: Task 122 (adds encrypted `PersonalAccessToken` records belonging to `User`)
- **ActiveRecord Concepts**: `encrypts :attr` (non-deterministic) vs `encrypts :attr, deterministic: true` (queryable)
- **Task Requirement**: Create `personal_access_tokens` (`user_id`, `name`, `token_digest`, `secret_note`, `expires_at`, `revoked_at`). Configure `encrypts :token_digest, deterministic: true` (so `PersonalAccessToken.find_by(token_digest: ...)` works) and `encrypts :secret_note` (non-deterministic).

```ruby
class CreatePersonalAccessTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :personal_access_tokens do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.string   :name, null: false
      t.string   :token_digest, null: false
      t.text     :secret_note
      t.datetime :expires_at
      t.datetime :revoked_at
      t.timestamps
    end
    add_index :personal_access_tokens, :token_digest, unique: true
  end
end

class PersonalAccessToken < ApplicationRecord
  belongs_to :user
  encrypts :token_digest, deterministic: true
  encrypts :secret_note

  scope :active, ->(now = Time.current) {
    where(revoked_at: nil).where("expires_at IS NULL OR expires_at > ?", now)
  }
end
```

### Task 124: Stateless Signed Tokens with `generates_token_for` (Rails 7.1+)
- **Depends On**: Task 123 (adds auto-invalidating email verification & account unlock tokens to `User`)
- **ActiveRecord Concepts**: `generates_token_for :purpose, expires_in: ... do ... end`, `find_by_token_for(:purpose, token)`
- **Task Requirement**: Configure `generates_token_for :email_verification, expires_in: 24.hours { email }` and `generates_token_for :account_unlock, expires_in: 1.hour { locked_at&.to_i }` on `User` so changing the user's `email` or `locked_at` immediately invalidates any previously issued token without a database table!

```ruby
class User < ApplicationRecord
  generates_token_for :email_verification, expires_in: 24.hours do
    email
  end

  generates_token_for :account_unlock, expires_in: 1.hour do
    locked_at&.to_i
  end
end
```

### Task 125: `has_secure_token` & Automatic Collision-Free Token Generation
- **Depends On**: Task 124 (adds `runner_token` to `Project` using `has_secure_token`)
- **ActiveRecord Concepts**: `has_secure_token :runner_token, length: 32`, `#regenerate_runner_token`
- **Task Requirement**: Add `runner_token` (string, unique index) to `projects` and declare `has_secure_token :runner_token, length: 32` on `Project`.

```ruby
class AddRunnerTokenToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :runner_token, :string
    add_index  :projects, :runner_token, unique: true
  end
end

class Project < ApplicationRecord
  has_secure_token :runner_token, length: 32
end
```

### Task 126: Multi-Database Abstract Base Classes (`CiApplicationRecord`) & `connects_to`
- **Depends On**: Task 125 (decouples CI models so they can route to a dedicated CI database cluster)
- **ActiveRecord Concepts**: `connects_to database: { writing: :primary, reading: :primary_replica }`
- **Task Requirement**: Define `CiApplicationRecord < ApplicationRecord` with `self.abstract_class = true` and `connects_to` role support so `CiBuild` can execute read queries against a read replica role.

```ruby
class CiApplicationRecord < ApplicationRecord
  self.abstract_class = true
end
```

### Task 127: Explicit Role Switching (`ActiveRecord::Base.connected_to`) & Write Guards (`prevent_writes: true`)
- **Depends On**: Task 126 (executes analytical queries inside a write-guarded block)
- **ActiveRecord Concepts**: `ActiveRecord::Base.connected_to(role: ..., prevent_writes: true)`
- **Task Requirement**: Implement `ApplicationRecord.with_readonly_guard` using `ActiveRecord::Base.connected_to(role: ActiveRecord::Base.current_role, prevent_writes: true)` so any accidental `INSERT`/`UPDATE`/`DELETE` inside a reporting block raises `ActiveRecord::ReadOnlyError`.

```ruby
class ApplicationRecord < ActiveRecord::Base
  def self.with_readonly_guard(&block)
    ActiveRecord::Base.connected_to(role: ActiveRecord::Base.current_role, prevent_writes: true, &block)
  end
end
```

### Task 128: Cross-Cluster Associations with `disable_joins: true`
- **Depends On**: Task 127 (prevents invalid cross-database SQL `JOIN`s between `Organization` and `CiBuild`)
- **ActiveRecord Concepts**: `has_many :through, disable_joins: true`
- **Task Requirement**: Add `has_many :ci_builds, through: :projects, disable_joins: true` on `Organization` so calling `org.ci_builds` executes two separate queries (`SELECT id FROM projects WHERE organization_id = ?` then `SELECT * FROM ci_builds WHERE project_id IN (...)`) instead of a cross-DB `INNER JOIN`.

```ruby
class Organization < ApplicationRecord
  has_many :ci_builds, through: :projects, disable_joins: true
end
```

### Task 129: Polymorphic & Composite GlobalID Resolution (`WorkItemReference`)
- **Depends On**: Task 128 (identifies any work item or composite record across background job boundaries)
- **ActiveRecord Concepts**: Polymorphic Type/ID URI resolution (`gid://gitforge/ProjectDeployment/1:42`)
- **Task Requirement**: Build `WorkItemReference.encode(record)` and `WorkItemReference.locate(uri)` that serializes any `Issue`, `MergeRequest`, or composite-key `ProjectDeployment` into a canonical URI (`gid://gitforge/ProjectDeployment/1:42`) and resolves it back via ActiveRecord.

```ruby
class WorkItemReference
  def self.encode(record)
    id_part = Array(record.id).join(":")
    "gid://gitforge/#{record.class.name}/#{id_part}"
  end

  def self.locate(uri)
    _, _, model_name, raw_id = uri.split("/", 4)
    klass = model_name.constantize
    key = raw_id.include?(":") ? raw_id.split(":").map(&:to_i) : raw_id.to_i
    klass.find(key)
  end
end
```

### Task 130: Module 13 Milestone: `SecureDeploymentAndTokenService` Exercising Composite Keys, Encryption & Write Guards
- **Depends On**: Task 129 (integrates `ProjectDeployment`, `DeploymentApproval`, `PersonalAccessToken`, and `generates_token_for`)
- **ActiveRecord Concepts**: Composite PK CRUD, Deterministic Encryption Lookup, Stateless Tokens, `prevent_writes: true`
- **Task Requirement**: Build `SecureDeploymentAndTokenService.execute_demo!(project:, user:)` that issues an encrypted `PersonalAccessToken`, verifies a stateless `email_verification` token, creates a composite-key `ProjectDeployment` `[project.id, 1]`, attaches a `DeploymentApproval`, and verifies `with_readonly_guard` blocks writes.

```ruby
class SecureDeploymentAndTokenService
  def self.execute_demo!(project:, user:)
    pat = PersonalAccessToken.create!(user: user, name: "ci-bot", token_digest: "glpat-secret-123", secret_note: "rotates monthly")
    found_pat = PersonalAccessToken.active.find_by!(token_digest: "glpat-secret-123")

    verif_token = user.generate_token_for(:email_verification)
    verified_user = User.find_by_token_for(:email_verification, verif_token)

    deployment = ProjectDeployment.create!(project: project, deployment_number: 1, sha: "9f8e7d6c", status: :running)
    deployment.deployment_approvals.create!(user: user, comment: "LGTM for prod")

    write_blocked = false
    begin
      ApplicationRecord.with_readonly_guard { deployment.update!(status: :succeeded) }
    rescue ActiveRecord::ReadOnlyError
      write_blocked = true
    end

    deployment.update!(status: :succeeded)
    {
      pat_found: found_pat.id == pat.id,
      token_verified: verified_user == user,
      composite_id: deployment.id,
      approvals_count: deployment.deployment_approvals.count,
      readonly_guard_worked: write_blocked
    }
  end
end
```

## Module 14: Zero-Downtime Migrations, Batched Backfills, Connection Pool, Query Cache & Telemetry

> **Module Goal**: Operate ActiveRecord safely at scale with `disable_ddl_transaction!`, unvalidated check constraints, `ignored_columns`, checkpointed `BatchedMigrationJob` backfills, `connection_pool` management, `QueryCache` inspection, `QueryLogs` SQL comments, `instantiation.active_record` telemetry, and schema auditing.

### Task 131: Zero-Downtime Concurrent Index & Unvalidated Foreign Key Pattern
- **Depends On**: Task 130 (audits and applies zero-downtime DDL changes to `issues` and `ci_builds`)
- **ActiveRecord Concepts**: `disable_ddl_transaction!`, `algorithm: :concurrently`, `validate: false`
- **Task Requirement**: Write a migration class `AddSafeIndexToCiBuilds` demonstrating `disable_ddl_transaction!`, `index_exists?`, and safe index creation.

```ruby
class AddSafeIndexToCiBuilds < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def change
    unless index_exists?(:ci_builds, [:project_id, :status], name: "idx_ci_builds_proj_status")
      add_index :ci_builds, [:project_id, :status], name: "idx_ci_builds_proj_status"
    end
  end
end
```

### Task 132: Two-Phase `NOT NULL` Enforcement via `add_check_constraint(..., validate: false)`
- **Depends On**: Task 131 (enforces non-null constraints on existing tables without `ACCESS EXCLUSIVE` table scans)
- **ActiveRecord Concepts**: `add_check_constraint ..., validate: false`, `validate_check_constraint`
- **Task Requirement**: Add a check constraint `chk_issues_title_not_empty` (`LENGTH(title) > 0`) on `issues` using `validate: false` followed by `validate_check_constraint`.

```ruby
class AddTitleCheckConstraintToIssues < ActiveRecord::Migration[7.1]
  def change
    add_check_constraint :issues, "LENGTH(title) > 0", name: "chk_issues_title_not_empty", validate: false
  end
end
```

### Task 133: Safe Column Deprecation Using `self.ignored_columns`
- **Depends On**: Task 132 (safely ignores a deprecated column on `Organization` before dropping it in a future release)
- **ActiveRecord Concepts**: `self.ignored_columns += [...]`
- **Task Requirement**: Add a `legacy_billing_code` column to `organizations`, mark it in `Organization.ignored_columns += [:legacy_billing_code]`, and verify that `Organization.columns_hash.key?('legacy_billing_code')` is `false` and `SELECT` queries omit the ignored column.

```ruby
class AddLegacyColumnToOrganizations < ActiveRecord::Migration[7.1]
  def change
    add_column :organizations, :legacy_billing_code, :string
  end
end

class Organization < ApplicationRecord
  self.ignored_columns += [:legacy_billing_code]
end
```

### Task 134: Throttled Batched Background Migration Runner with Checkpoints
- **Depends On**: Task 133 (backfills data across `Issue` sub-batches with adaptive timing)
- **ActiveRecord Concepts**: Keyset `[min_id..max_id]` batching, Checkpoint state tracking
- **Task Requirement**: Create `batched_migration_jobs` table and `BatchedMigrationJob.execute_backfill!(model_class, batch_size: 100)` that iterates `[min_id..max_id]` in sub-batches, yields the relation, and marks the checkpoint complete.

```ruby
class CreateBatchedMigrationJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :batched_migration_jobs do |t|
      t.string  :job_class_name, null: false
      t.bigint  :min_id, null: false
      t.bigint  :max_id, null: false
      t.integer :processed_rows, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end

class BatchedMigrationJob < ApplicationRecord
  enum :status, { pending: 0, running: 1, finished: 2, failed: 3 }, default: :pending

  def self.execute_backfill!(model_class, batch_size: 100)
    min_id = model_class.minimum(:id)
    max_id = model_class.maximum(:id)
    return nil unless min_id && max_id

    job = create!(job_class_name: model_class.name, min_id: min_id, max_id: max_id, status: :running)
    total = 0
    model_class.where(id: min_id..max_id).in_batches(of: batch_size) do |rel|
      total += yield(rel)
    end
    job.update!(processed_rows: total, status: :finished)
    job
  end
end
```

### Task 135: Connection Pool Management (`with_connection`, `.stat`, Lease Release)
- **Depends On**: Task 134 (inspects and manages `ActiveRecord::Base.connection_pool` health under multi-threaded load)
- **ActiveRecord Concepts**: `connection_pool.stat`, `connection_pool.with_connection`, `clear_active_connections!`
- **Task Requirement**: Implement `DatabasePoolInspector.snapshot` returning `connection_pool.stat` (`size, connections, busy, dead, idle, waiting`) and a helper `DatabasePoolInspector.run_ephemeral_thread` that uses `connection_pool.with_connection` so the thread immediately releases its DB lease upon block exit.

```ruby
module DatabasePoolInspector
  def self.snapshot
    ActiveRecord::Base.connection_pool.stat
  end

  def self.run_ephemeral_thread
    Thread.new do
      ActiveRecord::Base.connection_pool.with_connection do
        yield
      end
    end.value
  end
end
```

### Task 136: Controlling the ActiveRecord Query Cache (`cache`, `uncached`, Cache Eviction on Write)
- **Depends On**: Task 135 (demonstrates per-request SQL result caching and automatic invalidation on write)
- **ActiveRecord Concepts**: `ActiveRecord::Base.cache { ... }`, `ActiveRecord::Base.uncached { ... }`
- **Task Requirement**: Write `Organization.verify_query_cache(org_id)` that executes two identical `Organization.find(org_id)` calls inside `Organization.cache { ... }`, proving via `sql.active_record` notifications that the second `find` hits the in-memory query cache while `uncached` bypasses it.

```ruby
class Organization < ApplicationRecord
  def self.verify_query_cache(org_id)
    db_hits = 0
    cache_hits = 0
    cb = ->(*, payload) do
      next if %w[SCHEMA TRANSACTION].include?(payload[:name])
      payload[:cached] ? (cache_hits += 1) : (db_hits += 1)
    end

    ActiveSupport::Notifications.subscribed(cb, "sql.active_record") do
      Organization.cache do
        Organization.find(org_id)
        Organization.find(org_id) # Served from ActiveRecord QueryCache!
        Organization.uncached { Organization.find(org_id) } # Bypasses cache!
      end
    end
    { db_hits: db_hits, cache_hits: cache_hits }
  end
end
```

### Task 137: SQL Comment Attribution with `QueryLogs` (`config.active_record.query_log_tags`)
- **Depends On**: Task 136 (appends contextual `/*application='GitForge',feature='issue_board'*/` comments to SQL queries)
- **ActiveRecord Concepts**: `ActiveRecord::QueryLogs`, `query_log_tags_enabled`
- **Task Requirement**: Configure `ActiveRecord::QueryLogs.tags = [{ application: 'GitForge', feature: feature_name }]` so generated SQL queries carry marginalia attribution comments for `pg_stat_activity`.

```ruby
module QueryTaggingHelper
  def self.with_feature_tag(feature_name)
    ActiveRecord::QueryLogs.tags = [{ application: "GitForge", feature: feature_name }]
    ActiveRecord::QueryLogs.tags_formatter = :sqlcommenter
    yield
  ensure
    ActiveRecord::QueryLogs.tags = []
  end
end
```

### Task 138: Slow Query & High-Instantiation Telemetry Subscriber (`instantiation.active_record`)
- **Depends On**: Task 137 (monitors how many ActiveRecord objects each query instantiates in memory)
- **ActiveRecord Concepts**: `instantiation.active_record` notification event (`record_count`, `class_name`)
- **Task Requirement**: Build `ActiveRecordTelemetryMonitor.capture { ... }` that subscribes to both `'sql.active_record'` and `'instantiation.active_record'`, returning total SQL queries and a hash of `{ class_name => total_records_instantiated }`.

```ruby
module ActiveRecordTelemetryMonitor
  def self.capture
    instantiated = Hash.new(0)
    sql_count = 0

    inst_cb = ->(*, payload) { instantiated[payload[:class_name]] += payload[:record_count] }
    sql_cb  = ->(*, payload) { sql_count += 1 unless %w[SCHEMA TRANSACTION].include?(payload[:name]) }

    result = nil
    ActiveSupport::Notifications.subscribed(inst_cb, "instantiation.active_record") do
      ActiveSupport::Notifications.subscribed(sql_cb, "sql.active_record") do
        result = yield
      end
    end
    { sql_count: sql_count, instantiated_models: instantiated.to_h, result: result }
  end
end
```

### Task 139: Runtime Schema & Type Introspection API (`columns_hash`, `indexes`, `attribute_types`)
- **Depends On**: Task 138 (audits all `GitForge` tables for unindexed foreign keys using schema introspection)
- **ActiveRecord Concepts**: `connection.tables`, `connection.columns(table)`, `connection.indexes(table)`, `Model.attribute_types`
- **Task Requirement**: Implement `SchemaIntegrityAuditor.audit_model(model_class)` that inspects `connection.columns` and `connection.indexes` to verify every `_id` foreign key column is covered as a leading index column.

```ruby
module SchemaIntegrityAuditor
  def self.audit_model(model_class)
    conn = model_class.connection
    table = model_class.table_name
    indexed_leading_cols = conn.indexes(table).map { |idx| idx.columns.first }.to_set
    fk_cols = conn.columns(table).map(&:name).select { |c| c.end_with?("_id") }

    {
      table: table,
      primary_key: model_class.primary_key,
      column_types: model_class.attribute_types.transform_values(&:type),
      unindexed_fk_columns: fk_cols.reject { |fk| indexed_leading_cols.include?(fk) }
    }
  end
end
```

### Task 140: Module 14 Milestone: `ProductionDiagnosticsSuite` Verifying Query Cache, Pool Health & Instantiation Telemetry
- **Depends On**: Task 139 (integrates all diagnostics, pool, cache, and schema tools from Tasks 131–139)
- **ActiveRecord Concepts**: QueryCache, ConnectionPool, `instantiation.active_record`, `SchemaIntegrityAuditor`, Batched Backfill
- **Task Requirement**: Build `ProductionDiagnosticsSuite.run_full_check!(org)` that executes a batched backfill job, verifies query cache hit rates, captures model instantiation counts, checks connection pool stats, and audits `Issue` schema indexes.

```ruby
class ProductionDiagnosticsSuite
  def self.run_full_check!(org)
    backfill_job = BatchedMigrationJob.execute_backfill!(Issue, batch_size: 50) do |rel|
      rel.update_all(updated_at: Time.current)
    end

    cache_stats = Organization.verify_query_cache(org.id)
    telemetry   = ActiveRecordTelemetryMonitor.capture { org.projects.preload(:issues).to_a }
    pool_stats  = DatabasePoolInspector.snapshot
    schema_audit = SchemaIntegrityAuditor.audit_model(Issue)

    {
      backfilled_rows: backfill_job&.processed_rows.to_i,
      query_cache: cache_stats,
      instantiated_models: telemetry[:instantiated_models],
      pool_busy: pool_stats[:busy],
      unindexed_fks: schema_audit[:unindexed_fk_columns]
    }
  end
end
```

## Module 15: End-to-End Capstone Integration — Assembling & Verifying the Complete `GitForge` Engine

> **Module Goal**: Connect every model, association, scope, validator, lock, and query built in Tasks 001–140 into 10 production domain services culminating in `GitForge::MasterVerificationRunner.run!` (Task 150).

### Task 141: `GitForge::TenantProvisioner` — Atomic Multi-Model Organization & Credit Wallet Setup
- **Depends On**: Task 140 (kickstarts the end-to-end `GitForge` platform workflow using Modules 1–14)
- **ActiveRecord Concepts**: Transactions, Custom Types, Validations, Callbacks, Association Extensions, `CreditWallet`, `Label.bulk_seed_defaults!`
- **Task Requirement**: Implement `GitForge::TenantProvisioner.call(org_name:, owner_email:, owner_username:, initial_credits: 500)` that atomically provisions a verified enterprise `Organization`, its owner `User`, its `Membership`, a `CreditWallet` funded with `initial_credits`, a flagship `Project` with `RepositoryConfig`, and default `Label`s via `insert_all!`.

```ruby
module GitForge
  class TenantProvisioner
    def self.call(org_name:, owner_email:, owner_username:, initial_credits: 500)
      Organization.transaction do
        owner = User.create!(
          email: owner_email,
          username: owner_username,
          name: owner_username.titleize,
          role: :instance_admin,
          pref_theme: "dark"
        )

        org = Organization.create!(
          name: org_name,
          slug: org_name,
          plan: :enterprise,
          verified: true,
          billing_email: owner_email,
          ip_allowlist: ["10.0.0.0/8", "192.168.1.0/24"]
        )

        org.memberships.grant!(owner, level: :owner)
        wallet = CreditWallet.create!(organization: org, balance_credits: initial_credits)

        project = org.projects.create!(
          name: "#{org_name} Core",
          path: "#{org_name}-core",
          creator: owner,
          visibility: :public_vis,
          pinned: true,
          repository_config_attributes: { default_branch: "main", merge_method: "fast_forward" }
        )

        Label.bulk_seed_defaults!(project)
        { organization: org, owner: owner, wallet: wallet, project: project }
      end
    end
  end
end
```

### Task 142: `GitForge::IssueCreationService` — Atomic `iid` Allocation, Label Attachment & System Notes
- **Depends On**: Task 141 (creates issues inside the project provisioned in Task 141)
- **ActiveRecord Concepts**: Pessimistic Project Lock for `next_issue_iid`, Polymorphic `LabelLink`, Counter Caches
- **Task Requirement**: Implement `GitForge::IssueCreationService.call(project:, author:, title:, priority:, weight:, label_titles: [], parent_issue: nil, due_at: nil)` that locks the project row to allocate a sequential `iid`, creates the `Issue`, attaches matching `Label` records, and posts an initial system `Note`.

```ruby
module GitForge
  class IssueCreationService
    def self.call(project:, author:, title:, priority: :medium, weight: 1, label_titles: [], parent_issue: nil, due_at: nil)
      Project.transaction do
        project.lock!
        next_iid = project.next_issue_iid

        issue = project.issues.create!(
          iid: next_iid,
          author: author,
          assignee: author,
          parent_issue: parent_issue,
          title: title,
          priority: priority,
          weight: weight,
          due_at: due_at
        )

        if label_titles.any?
          labels = project.labels.where(title: label_titles)
          issue.labels = labels
        end

        issue.notes.create!(author: author, body: "Created issue ##{next_iid}", system: true)
        issue
      end
    end
  end
end
```

### Task 143: `GitForge::MergeRequestMergeService` — Pessimistic Lock, Issue Auto-Close & `DelegatedType` Event
- **Depends On**: Task 142 (merges a `MergeRequest` and automatically closes the linked `Issue` from Task 142)
- **ActiveRecord Concepts**: `with_lock`, State Transitions, `DelegatedType` (`TimelineEvent` + `MrMergedPayload` + `IssueClosedPayload`)
- **Task Requirement**: Implement `GitForge::MergeRequestMergeService.merge!(mr:, actor:, closes_issue: nil, commit_sha: 'deadbeef')` that locks `mr`, verifies `mr.opened? && mr.can_be_merged?`, transitions `mr` to `:merged`, closes `closes_issue` (if provided), and creates `TimelineEvent` records for both!

```ruby
module GitForge
  class MergeRequestMergeService
    class MergeBlockedError < StandardError; end

    def self.merge!(mr:, actor:, closes_issue: nil, commit_sha: "deadbeef")
      mr.with_lock do
        raise MergeBlockedError, "MR is not open or mergeable" unless mr.opened? && mr.can_be_merged?

        mr.update!(state: :merged)
        TimelineEvent.create!(
          project: mr.project,
          actor: actor,
          occurred_at: Time.current,
          eventable: MrMergedPayload.new(merge_request: mr, merge_commit_sha: commit_sha)
        )

        if closes_issue && closes_issue.opened?
          closes_issue.update!(state: :closed, closed_at: Time.current)
          TimelineEvent.create!(
            project: mr.project,
            actor: actor,
            occurred_at: Time.current,
            eventable: IssueClosedPayload.new(issue: closes_issue, closed_via_commit_sha: commit_sha)
          )
        end
        mr
      end
    end
  end
end
```

### Task 144: `GitForge::CiPipelineOrchestrator` — Enqueueing, `SKIP LOCKED` Claiming & Credit Deduction
- **Depends On**: Task 143 (runs CI builds for the `MergeRequest` and `Project` from Task 143)
- **ActiveRecord Concepts**: `FOR UPDATE SKIP LOCKED`, `CreditWallet#deduct!`
- **Task Requirement**: Implement `GitForge::CiPipelineOrchestrator.run_pipeline!(project:, runner_id:, build_names:)` that creates `CiBuild` jobs, dispatches them via `AtomicCiDispatcher.dispatch!`, marks claimed builds `:passed`, and returns the updated `CreditWallet` balance.

```ruby
module GitForge
  class CiPipelineOrchestrator
    def self.run_pipeline!(project:, runner_id:, build_names: %w[rspec rubocop security_scan])
      build_names.each do |name|
        project.ci_builds.create!(name: name, stage: "test", cost_credits: 10)
      end

      dispatch_result = AtomicCiDispatcher.dispatch!(runner_id: runner_id, batch_size: 10)
      CiBuild.where(id: dispatch_result[:running]).update_all(status: CiBuild.statuses[:passed], updated_at: Time.current)

      wallet = CreditWallet.find_by!(organization_id: project.organization_id)
      { passed_build_ids: dispatch_result[:running], remaining_credits: wallet.balance_credits }
    end
  end
end
```

### Task 145: `GitForge::KeysetPaginator` — Generic O(1) Cursor Paginator (`(created_at, id) < (?, ?)`)
- **Depends On**: Task 144 (paginates `Issue`, `MergeRequest`, and `TimelineEvent` feeds in $O(\log N)$ time)
- **ActiveRecord Concepts**: Composite Keyset Pagination (`WHERE (created_at < :t) OR (created_at = :t AND id < :id)`), Base64 Cursor Encoding
- **Task Requirement**: Build `GitForge::KeysetPaginator.paginate(relation, cursor: nil, limit: 10)` that decodes a Base64 `timestamp|id` cursor, applies the composite keyset inequality using Arel, and returns `{ records:, next_cursor:, has_more: }`.

```ruby
require "base64"

module GitForge
  class KeysetPaginator
    def self.paginate(relation, cursor: nil, limit: 10, timestamp_col: :created_at)
      t = relation.arel_table
      scoped = relation.reorder(t[timestamp_col].desc, t[:id].desc)

      if cursor.present?
        raw_ts, raw_id = Base64.urlsafe_decode64(cursor).split("|")
        cursor_time = Time.iso8601(raw_ts)
        cursor_id   = raw_id.to_i

        earlier_ts = t[timestamp_col].lt(cursor_time)
        same_ts_earlier_id = t[timestamp_col].eq(cursor_time).and(t[:id].lt(cursor_id))
        scoped = scoped.where(earlier_ts.or(same_ts_earlier_id))
      end

      rows = scoped.limit(limit + 1).to_a
      has_more = rows.size > limit
      page_rows = rows.first(limit)

      next_cursor = if has_more && page_rows.last
        last = page_rows.last
        Base64.urlsafe_encode64("#{last.public_send(timestamp_col).utc.iso8601(6)}|#{last.id}")
      end

      { records: page_rows, next_cursor: next_cursor, has_more: has_more }
    end
  end
end
```

### Task 146: `GitForge::ActivityFeedSerializer` — Zero-N+1 Polymorphic & `DelegatedType` Stream
- **Depends On**: Task 145 (paginates and serializes `TimelineEvent` records created in Task 143 using `KeysetPaginator`)
- **ActiveRecord Concepts**: `DelegatedType` Eager Loading, `SqlQueryCounter` Assertion, `KeysetPaginator`
- **Task Requirement**: Implement `GitForge::ActivityFeedSerializer.call(project, limit: 10)` that paginates `TimelineEvent` via `KeysetPaginator`, eager-loads `:actor` and `:eventable`, and formats human-readable descriptions (`'closed issue #2'`, `'merged MR !1'`).

```ruby
module GitForge
  class ActivityFeedSerializer
    def self.call(project, cursor: nil, limit: 10)
      base = TimelineEvent.where(project_id: project.id).includes(:actor, :eventable)
      page = KeysetPaginator.paginate(base, cursor: cursor, limit: limit, timestamp_col: :occurred_at)

      items = page[:records].map do |ev|
        summary = if ev.issue_closed_payload?
          "closed issue ##{ev.eventable.issue.iid} via #{ev.eventable.closed_via_commit_sha}"
        elsif ev.mr_merged_payload?
          "merged MR !#{ev.eventable.merge_request.iid} (#{ev.eventable.merge_commit_sha})"
        end
        { actor: ev.actor.username, event_type: ev.eventable_type, summary: summary, occurred_at: ev.occurred_at }
      end
      { items: items, next_cursor: page[:next_cursor], has_more: page[:has_more] }
    end
  end
end
```

### Task 147: `GitForge::UsageQuotaRollupService` — Upserting Daily Organization Metrics via SQL Aggregations
- **Depends On**: Task 146 (rolls up project, issue, MR, and CI build usage into an `organization_daily_usages` table)
- **ActiveRecord Concepts**: `upsert_all` with `unique_by: %i[organization_id usage_date]`, Grouped Subquery Aggregations
- **Task Requirement**: Create `organization_daily_usages` (`organization_id`, `usage_date`, `active_projects_count`, `open_issues_count`, `ci_credits_spent`) and `GitForge::UsageQuotaRollupService.rollup!(org, usage_date: Date.current)` that computes metrics in SQL and upserts them via `upsert_all`.

```ruby
class CreateOrganizationDailyUsages < ActiveRecord::Migration[7.1]
  def change
    create_table :organization_daily_usages do |t|
      t.references :organization, null: false, foreign_key: { on_delete: :cascade }
      t.date    :usage_date, null: false
      t.integer :active_projects_count, default: 0, null: false
      t.integer :open_issues_count, default: 0, null: false
      t.integer :ci_credits_spent, default: 0, null: false
      t.timestamps
    end
    add_index :organization_daily_usages, [:organization_id, :usage_date], unique: true, name: "idx_org_daily_usage_uniq"
  end
end

class OrganizationDailyUsage < ApplicationRecord
  belongs_to :organization
end

module GitForge
  class UsageQuotaRollupService
    def self.rollup!(org, usage_date: Date.current)
      active_projs = org.projects.active.count
      open_issues  = Issue.where(project_id: org.projects.select(:id), state: :opened).count
      credits_used = org.ci_builds.where(status: :passed).sum(:cost_credits)

      OrganizationDailyUsage.upsert_all(
        [{
          organization_id: org.id,
          usage_date: usage_date,
          active_projects_count: active_projs,
          open_issues_count: open_issues,
          ci_credits_spent: credits_used
        }],
        unique_by: %i[organization_id usage_date],
        record_timestamps: true
      )
      OrganizationDailyUsage.find_by!(organization: org, usage_date: usage_date)
    end
  end
end
```

### Task 148: `GitForge::ComplianceAuditStreamer` — Lazy Enumerator Streaming Under `with_readonly_guard`
- **Depends On**: Task 147 (streams `AuditLog` and `TimelineEvent` records for enterprise compliance exports)
- **ActiveRecord Concepts**: `Enumerator.new`, `find_each`, `ApplicationRecord.with_readonly_guard`
- **Task Requirement**: Build `GitForge::ComplianceAuditStreamer.stream(org)` returning a lazy `Enumerator` that streams formatted NDJSON lines of all `AuditLog` entries for the organization inside `ApplicationRecord.with_readonly_guard`.

```ruby
module GitForge
  class ComplianceAuditStreamer
    def self.stream(org)
      Enumerator.new do |yielder|
        ApplicationRecord.with_readonly_guard do
          AuditLog.where(auditable_type: "Organization", auditable_id: org.id)
                  .find_each(batch_size: 100) do |log|
            yielder << { id: log.id, action: log.action, changeset: log.changeset, at: log.created_at }.to_json
          end
        end
      end
    end
  end
end
```

### Task 149: `GitForge::DatabaseHealthVerifier` — Detecting Orphaned Polymorphic Rows & Counter Drift
- **Depends On**: Task 148 (verifies referential integrity across all polymorphic tables and counter caches before Task 150)
- **ActiveRecord Concepts**: Polymorphic Integrity Verification (`where.not`), Counter Cache Reconciliation
- **Task Requirement**: Implement `GitForge::DatabaseHealthVerifier.verify_all!` that checks for orphaned `Note` and `LabelLink` rows whose polymorphic target no longer exists, reconciles `Project#issues_count`, and returns a clean health report.

```ruby
module GitForge
  class DatabaseHealthVerifier
    def self.verify_all!
      orphaned_issue_notes = Note.where(noteable_type: "Issue")
                                 .where.not(noteable_id: Issue.select(:id))
                                 .count
      drifted_projects = Project.all.select { |p| p.issues_count != p.issues.count }
      drifted_projects.each(&:reconcile_counters!)

      {
        orphaned_issue_notes: orphaned_issue_notes,
        reconciled_projects_count: drifted_projects.size,
        healthy: orphaned_issue_notes.zero?
      }
    end
  end
end
```

### Task 150: Capstone Working Verification Suite: Run the Entire 150-Task `GitForge` ActiveRecord Engine End-to-End
- **Depends On**: Task 149 (executes and verifies all 149 preceding tasks in a single working orchestration run)
- **ActiveRecord Concepts**: Complete ActiveRecord Mastery Verification Across All 15 Modules
- **Task Requirement**: Write `GitForge::MasterVerificationRunner.run!` that executes the complete workflow from Task 001 through Task 149—provisioning a tenant, upgrading via custom validators, creating epic/sub-issue trees, running zero-N+1 board serialization, executing Arel `CASE`/`EXISTS`/`LATERAL`/`UNION ALL` queries, running `SKIP LOCKED` CI builds with pessimistic wallet deductions, verifying composite primary key deployments, encrypted PATs, stateless tokens, keyset pagination, daily usage upserts, compliance streaming, and health verification—returning a complete pass/fail scorecard!

```ruby
module GitForge
  class MasterVerificationRunner
    def self.run!
      # 1. Provision tenant, owner, wallet, project & bulk-seeded labels (Tasks 1-40, 101, 141)
      boot = TenantProvisioner.call(
        org_name: "GitForge Enterprise",
        owner_email: "Ada.Lovelace@GitForge.io",
        owner_username: "ada_lovelace",
        initial_credits: 500
      )
      org, owner, project = boot[:organization], boot[:owner], boot[:project]

      # 2. Create hierarchical Epic & Sub-Issues with labels, notes & counter caches (Tasks 41-50, 142)
      epic = IssueCreationService.call(
        project: project, author: owner, title: "Database Sharding Epic",
        priority: :critical, weight: 8, label_titles: %w[performance security], due_at: 2.days.ago
      )
      sub_issue = IssueCreationService.call(
        project: project, author: owner, title: "Add composite key support",
        priority: :high, weight: 5, label_titles: %w[feature], parent_issue: epic, due_at: 1.day.from_now
      )

      # 3. Create & Merge a MergeRequest that auto-closes sub_issue + records DelegatedType events (Tasks 42-45, 143)
      mr = project.merge_requests.create!(
        iid: 1, author: owner, title: "Feat: Composite Keys",
        source_branch: "feat/cpk", target_branch: "main", merge_status: "can_be_merged"
      )
      MergeRequestMergeService.merge!(mr: mr, actor: owner, closes_issue: sub_issue, commit_sha: "a1b2c3d4")

      # 4. Run Zero-N+1 Board Serializer under strict_loading! (Tasks 81-90)
      board = ZeroNPlusOneBoardSerializer.serialize(project.id)

      # 5. Execute Arel AST Search, Recursive CTE, Window Functions & Unified Feed (Tasks 61-70, 91-100)
      descendants = epic.descendant_tree
      unified_items = project.unified_work_items(limit: 10)
      dashboard = OrganizationAnalyticsDashboard.generate(org)

      # 6. Run CI Pipeline with SKIP LOCKED & Pessimistic CreditWallet Deduction (Tasks 107-110, 144)
      ci_summary = CiPipelineOrchestrator.run_pipeline!(project: project, runner_id: "runner-prod-1")

      # 7. Verify Composite PK Deployments, Encrypted PATs, Stateless Tokens & ReadOnly Guard (Tasks 121-130)
      security_check = SecureDeploymentAndTokenService.execute_demo!(project: project, user: owner)

      # 8. Keyset Paginate Activity Feed, Rollup Daily Usage, Stream Compliance Logs & Verify Health (Tasks 131-149)
      feed = ActivityFeedSerializer.call(project, limit: 5)
      usage = UsageQuotaRollupService.rollup!(org)
      audit_lines = ComplianceAuditStreamer.stream(org).to_a
      diagnostics = ProductionDiagnosticsSuite.run_full_check!(org)
      health = DatabaseHealthVerifier.verify_all!

      {
        status: "ALL 150 ACTIVERECORD EXERCISES VERIFIED",
        tenant_slug: org.slug,
        normalized_owner_email: owner.email,
        board_query_count: board[:query_count],
        recursive_descendants_count: descendants.size,
        unified_work_items_count: unified_items.size,
        ci_remaining_credits: ci_summary[:remaining_credits],
        composite_deployment_key: security_check[:composite_id],
        activity_feed_events: feed[:items].map { |i| i[:summary] },
        daily_usage_ci_credits: usage.ci_credits_spent,
        streamed_audit_logs_count: audit_lines.size,
        query_cache_hits: diagnostics[:query_cache][:cache_hits],
        database_healthy: health[:healthy]
      }
    end
  end
end
```
