class CreateExtensions < ActiveRecord::Migration[8.1]
  def change
    create_table :extensions do |t|
      t.integer    :number,  null: false
      t.references :tenant,  null: true, foreign_key: true
      t.references :user,    null: true, foreign_key: true
      t.string     :notes
      t.timestamps
    end
    add_index :extensions, [:tenant_id, :number], unique: true
  end
end