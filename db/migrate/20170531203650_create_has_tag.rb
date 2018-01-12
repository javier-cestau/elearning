class CreateHasTag < ActiveRecord::Migration[5.0]
  def change
    create_table :has_tags do |t|
      t.references :tag, foreign_key: true
      t.references :course, foreign_key: true
    end
  end
end
