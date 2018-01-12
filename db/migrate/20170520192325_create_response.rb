class CreateResponse < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.text :description
    end
  end
end
