class CreateDoTest < ActiveRecord::Migration[5.0]
  def change
    create_table :do_tests do |t|
      t.references :user, foreign_key: true
      t.references :test, foreign_key: true
      t.references :do_course, foreign_key: true
      t.integer :duration, default: 0
      t.integer :grade, default: 0
      t.integer :active, default: 1

      t.timestamps

    end
  end
end
