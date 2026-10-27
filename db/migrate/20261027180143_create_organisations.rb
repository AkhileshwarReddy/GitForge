class CreateOrganisations < ActiveRecord::Migration[8.1]
  def change
    create_table :organisations do |t|
      t.string :name, limit: 120, null: false
      t.string :slug, limit: 80, null: false
      t.integer :plan, default: 0, null: false
      t.string :billing_email
      t.boolean :verified, default: false, null: false

      t.timestamps
    end
  end
end
