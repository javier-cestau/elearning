class CreateDoTemplate < ActiveRecord::Migration[5.0]
  def change
    create_table :do_templates do |t|
      t.references :template, foreign_key: true
      t.references :user, foreign_key: true
      t.references :survey, foreign_key: true
      t.references :response, foreign_key: true
      t.integer :sequence
      t.timestamps

    end
  end
end
