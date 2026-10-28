class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :organisation, null: false, foreign_key: { on_delete: :cascade }
      t.references :creator, null: false, foreign_key: { to_table: :users, on_delete: :restrict }
      t.string :name, limit: 120, null: false
      t.string :path, limit: 80, null: false
      t.integer :visibility, default: 0, null: false
      t.integer :start_count, default: 0, null: false
      t.boolean :archived, default: false, null: false

      t.timestamps
    end
  end
end
