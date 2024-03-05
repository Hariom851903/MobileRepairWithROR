class Order < ApplicationRecord
  belongs_to :mobile
  belongs_to :shop
  has_one :track_order 
end
