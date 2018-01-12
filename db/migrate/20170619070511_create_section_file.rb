class CreateSectionFile < ActiveRecord::Migration[5.0]
  def change
    create_table :section_files do |t|
      t.references :section, foreign_key: true
      t.attachment :file

    end
  end
end
