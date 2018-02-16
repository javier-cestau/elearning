class CreateHasAnswerDescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :has_answer_descriptions do |t|
      t.text :description
      t.references :question, foreign_key: true
      t.references :do_test, foreign_key: true

      t.timestamps
    end
  end
end
