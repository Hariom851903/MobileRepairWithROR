class Addcolumntoprofiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :dob, :date
  end
end
