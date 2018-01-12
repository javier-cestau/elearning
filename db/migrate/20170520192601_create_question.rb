class CreateQuestion < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :sequence
      t.text :description
      t.references :test, foreign_key: true
      t.references :type_question, foreign_key: true
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
