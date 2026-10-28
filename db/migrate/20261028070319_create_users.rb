class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username, limit: 60, null: false
      t.string :name, null: false
      t.integer :role, default: 0, null: false
      t.integer :failed_attempts, default: 0, null: false
      t.datetime :locked_at
      t.jsonb :preferences, default: {}, null: false

      t.timestamps
    end

    add_index :users, "LOWER(email)", unique: true, name: "index_users_on_lower_email"
    add_index :users, :username, unique: true
    add_check_constraint :users, "failed_attempts >= 0", name: "chk_users_failed_attempts_non_negative"
  end
end
