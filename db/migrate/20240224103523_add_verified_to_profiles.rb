class AddVerifiedToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :verified, :boolean
  end
end
