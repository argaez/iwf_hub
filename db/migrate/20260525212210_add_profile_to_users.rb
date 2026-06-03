class AddProfileToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :document_number, :string
    add_column :users, :phone, :string
    add_column :users, :position, :string
    add_column :users, :hire_date, :date
    add_column :users, :termination_date, :date
    add_column :users, :discarded_at, :datetime
  end
end