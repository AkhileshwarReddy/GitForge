class CreateMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :memberships do |t|
      t.references :organisation, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.integer :access_level, default: 30, null: false

      t.timestamps
    end

    add_index :memberships, [ :organisation_id, :user_id ], unique: true
  end
end
