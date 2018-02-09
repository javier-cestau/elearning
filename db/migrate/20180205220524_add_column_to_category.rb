class AddColumnToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :description, :string
    add_attachment :categories, :photo
  end
end
