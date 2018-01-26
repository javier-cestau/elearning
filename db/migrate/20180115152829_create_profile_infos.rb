class CreateProfileInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :profile_infos do |t|
      t.references :profile, foreign_key: true
      t.string :question
      t.string :answer

      t.timestamps
    end
  end
end
