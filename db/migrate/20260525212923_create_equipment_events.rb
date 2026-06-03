class CreateEquipmentEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :equipment_events do |t|
      t.string :event_type
      t.date :event_date
      t.string :performed_by
      t.decimal :cost
      t.text :notes
      t.references :equipment, null: true, foreign_key: true

      t.timestamps
    end
  end
end
