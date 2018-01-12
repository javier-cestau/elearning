class CreateDoCourse < ActiveRecord::Migration[5.0]
  def change
    create_table :do_courses do |t|
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.date :start_date
      t.date :finished_at
      t.integer :enroll
      t.integer :failed, default: 0
      t.timestamps

    end
  end
end
