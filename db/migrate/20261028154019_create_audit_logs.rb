class CreateAuditLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :audit_logs do |t|
      t.references :auditable, polymorphic: true, null: false
      t.string :action, null: false
      t.jsonb :changeset, null: false

      t.timestamps
    end
  end
end
