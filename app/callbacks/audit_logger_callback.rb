class AuditLoggerCallback
    def after_save(record)
        return if record.saved_changes.except("updated_at").empty?
        action = record.previously_new_record? ? "create" : "update"

        AuditLog.create!(
            auditable_type: record.class.name,
            auditable_id: record.id,
            action: action,
            changeset: record.saved_changes.except("updated_at"),
        )
    end
end
