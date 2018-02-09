class AddAutoToTest < ActiveRecord::Migration[5.1]
  def change
    add_column :tests, :auto, :bool
  end
end
