class CreateTrackOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :track_orders do |t|
      t.string :tracking_id  
      t.references :order,null: false ,foreign_key: true 
      t.timestamps
    end
  end
end
