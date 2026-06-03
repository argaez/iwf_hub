class CreateTenants < ActiveRecord::Migration[8.1]
  def change
    create_table :tenants do |t|
      t.string :name, null: false
      t.string :subdomain, null: false
      t.string :plan, default: "free"
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :tenants, :subdomain, unique: true
  end
end