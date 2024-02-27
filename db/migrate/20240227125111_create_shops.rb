class CreateShops < ActiveRecord::Migration[7.1]
  def change
    create_table :shops do |t|
      t.string :s_name
      t.string :s_username
      t.string :password_digest
      t.string :state
      t.string :district
      t.string :city
      t.string :address
      t.string :image
      t.references :profile, foreign_key: true 
      t.timestamps
    end
  end
end
