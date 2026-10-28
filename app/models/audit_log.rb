class AuditLog < ApplicationRecord
  include ActiveRecord::Suppressor

  belongs_to :auditable, polymorphic: true
end
