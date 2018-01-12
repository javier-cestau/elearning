class CreatePrelation < ActiveRecord::Migration[5.0]
  def change
    create_table :prelations do |t|
      t.references :course, foreign_key: true
      t.integer :prelated_by
      t.timestamps

    end
  end
end
