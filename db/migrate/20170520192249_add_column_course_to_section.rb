class AddColumnCourseToSection < ActiveRecord::Migration[5.0]
  def change
    add_reference :sections, :course, foreign_key: true
  end
end
