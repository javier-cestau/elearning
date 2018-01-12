class CreateHasAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :has_answers do |t|
      t.references :answer, foreign_key: true
      t.references :do_test, foreign_key: true

      t.timestamps
    end
  end
end
