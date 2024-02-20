class ChangeDatatypetoprofiles < ActiveRecord::Migration[7.1]
  def change
      def up 
        change_column :profiles, :dob, :date
        #Ex:- change_column("admin_users", "email", :string, :limit =>25)
      end
      def down 
        change_column :profiles, :dob, :time
      end
  end
end
