class AddColumnToDepartment < ActiveRecord::Migration[5.1]
  def change
    add_column :departments, :description, :string
    add_attachment :departments, :photo

  end
end
