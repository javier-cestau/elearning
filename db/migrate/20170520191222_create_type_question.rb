class CreateTypeQuestion < ActiveRecord::Migration[5.0]
  def change
    create_table :type_questions do |t|
      t.string :name
      t.integer :sequence
      
    end
  end
end
