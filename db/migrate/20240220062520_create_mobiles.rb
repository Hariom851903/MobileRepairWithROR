class CreateMobiles < ActiveRecord::Migration[7.1]
  def change
    create_table :mobiles do |t|
      t.string :imei
      t.string :model
      t.string :brand
      t.references :profile, foreign_key: true 
      t.timestamps
    end
  end
end
