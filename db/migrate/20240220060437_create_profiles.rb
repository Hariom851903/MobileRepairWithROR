class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :password_digest
      t.string :phonenumber
      t.string :state
      t.string :city
      t.string :address
      t.string :gender
      t.time :dob
      t.string :user

      t.timestamps
    end
  end
end
