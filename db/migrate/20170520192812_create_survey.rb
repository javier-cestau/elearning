class CreateSurvey < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.string :description
      t.integer :sequence
      t.references :type_survey, foreign_key: true
      t.references :template, foreign_key: true
      t.integer :required

      t.timestamps
    end
  end
end
