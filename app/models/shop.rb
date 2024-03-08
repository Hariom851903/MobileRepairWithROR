class Shop < ApplicationRecord
    has_secure_password
    belongs_to :profile
    has_many :orders
    has_many :mobiles, through: :orders 
    has_many :messages     
end
