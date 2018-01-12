class CreateCourse < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :scoping
      t.integer :prelation
      t.text :description
      t.integer :active
      t.attachment :cover
      t.date :start_date
      t.date :deadline_course
      t.date :deadline_inscription
      t.date :day_counter_update


      t.timestamps
    end
    add_index :courses, :name

  end
end
