class Removecolumntoprofiles < ActiveRecord::Migration[7.1]
  def change
      remove_column :profiles, :dob
      # add_column :profile, :dob, :date 
      #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
