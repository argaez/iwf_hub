class CreateAssignments < ActiveRecord::Migration[8.1]
  def change
    create_table :assignments do |t|
      t.datetime :assigned_at
      t.string :assigned_by
      t.string :condition_in
      t.string :condition_out
      t.text :notes
      t.date :expected_return_date
      t.datetime :returned_at
      t.references :equipment, null: true, foreign_key: true
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
