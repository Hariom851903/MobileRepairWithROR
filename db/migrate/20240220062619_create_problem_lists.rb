class CreateProblemLists < ActiveRecord::Migration[7.1]
  def change
    create_table :problem_lists do |t|
      t.string :p_name

      t.timestamps
    end
  end
end
