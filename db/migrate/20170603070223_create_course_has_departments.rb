class CreateCourseHasDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :course_has_departments do |t|
      t.references :department, foreign_key: true
      t.references :course, foreign_key: true
    end
  end
end
