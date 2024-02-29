class Order < ApplicationRecord
  belongs_to :mobile
  belongs_to :shop
end
