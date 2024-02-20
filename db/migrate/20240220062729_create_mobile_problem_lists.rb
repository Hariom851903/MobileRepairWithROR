class CreateMobileProblemLists < ActiveRecord::Migration[7.1]
  def change
    create_table :mobile_problem_lists do |t|
       t.references :mobile, foreign_key: true 
       t.references :problem_list, foreign_key: true
      t.timestamps
    end
  end
end
