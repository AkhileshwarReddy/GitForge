class FixProjectsColumns < ActiveRecord::Migration[8.1]
  def change
    rename_column :projects, :start_count, :stars_count
    add_column :projects, :pinned, :boolean, default: false, null: false
    add_index :projects, [ :organisation_id, :path ], unique: true
  end
end
