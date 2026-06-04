class CreatePermissions < ActiveRecord::Migration[8.1]
  def change
    create_table :permissions do |t|
      t.string  :role,        null: false
      t.string  :resource,    null: false
      t.boolean :can_index,   null: false, default: false
      t.boolean :can_show,    null: false, default: false
      t.boolean :can_create,  null: false, default: false
      t.boolean :can_update,  null: false, default: false
      t.boolean :can_destroy, null: false, default: false
      t.timestamps
    end
    add_index :permissions, [:role, :resource], unique: true
  end
end