class AddColumnCategoryToCourse < ActiveRecord::Migration[5.0]
  def change
    add_reference :courses, :category, foreign_key: true
  end
end
