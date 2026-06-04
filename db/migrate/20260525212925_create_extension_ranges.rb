class CreateExtensionRanges < ActiveRecord::Migration[8.1]
  def change
    create_table :extension_ranges do |t|
      t.references :tenant, null: true, foreign_key: true
      t.integer :range_start, null: false
      t.integer :range_end,   null: false
      t.string  :label,       null: false
      t.timestamps
    end
  end
end
