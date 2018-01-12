class CreateMultimediaSection < ActiveRecord::Migration[5.0]
  def change
    create_table :multimedia_sections do |t|
      t.references :section, foreign_key: true
      t.attachment :video
      t.attachment :image

    end
  end
end
