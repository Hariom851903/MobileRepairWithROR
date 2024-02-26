class Addcolumntomobiles < ActiveRecord::Migration[7.1]
  def change
    add_column :mobiles, :description, :text 
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
