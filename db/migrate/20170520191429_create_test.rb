class CreateTest < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.text :description
      t.integer :attemps_limits, default: 0
      t.integer :time_limit, default: 0
      t.integer :min_grade
      t.date :start_date
      t.date :deadline
      t.integer :required
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :tests, :deleted_at

  end
end
