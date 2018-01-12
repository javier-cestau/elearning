class CreateCommentCourse < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_courses do |t|
      t.text :body
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :prv_comment
      t.timestamps

    end
  end
end
