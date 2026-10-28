class CreateRepositoryConfigs < ActiveRecord::Migration[8.1]
  def change
    create_table :repository_configs do |t|
      t.references :project, null: false, index: { unique: true }, foreign_key: { on_delete: :cascade }
      t.string :default_branch, default: "main", null: false
      t.string :merge_method, default: "merge_commit", null: false
      t.boolean :lfs_enabled, default: true, null: false

      t.timestamps
    end
  end
end
