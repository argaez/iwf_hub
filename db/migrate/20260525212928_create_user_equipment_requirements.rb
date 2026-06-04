class CreateUserEquipmentRequirements < ActiveRecord::Migration[8.1]
  def change
    create_table :user_equipment_requirements do |t|
      t.references :tenant,             null: true,  foreign_key: true
      t.references :user,               null: false, foreign_key: true
      t.references :equipment_category, null: false, foreign_key: true
      t.references :assignment,         null: true,  foreign_key: true
      t.boolean    :is_adapter,         null: false, default: false
      t.string     :adapter_name
      t.boolean    :requires,           null: false, default: true
      t.integer    :position,           null: false, default: 0
      t.timestamps
    end

    add_index :user_equipment_requirements,
      [:user_id, :equipment_category_id, :is_adapter],
      name: "index_uer_on_user_category_adapter"
  end
end