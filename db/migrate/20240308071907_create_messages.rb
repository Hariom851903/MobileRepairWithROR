class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :body 
       t.references :profile,foreign_key: :true  
       t.references :shop, foreign_key: :true
      t.timestamps
    end
  end
end
