class CreateAnswer < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :description
      t.integer :is_correct
      t.references :question, foreign_key: true
      t.timestamps

    end
  end
end
