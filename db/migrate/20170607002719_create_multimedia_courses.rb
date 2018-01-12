class CreateMultimediaCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :multimedia_courses do |t|
      t.references :course, foreign_key: true
      t.attachment :video
      t.attachment :image
    end
  end
end
