class AddMetadataToOrganisations < ActiveRecord::Migration[8.1]
  def change
    change_table :organisations, bulk: true do |t|
      t.bigint :storage_limit_bytes, default: 5_368_709_120, null: false
      t.jsonb :settings, default: {}, null: false
      t.datetime :trial_ends_at
      t.datetime :deleted_at
    end
  end
end
