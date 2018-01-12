class AddColumnSectionToTest < ActiveRecord::Migration[5.0]
  def change
    add_reference :tests, :section, foreign_key: true
  end
end
