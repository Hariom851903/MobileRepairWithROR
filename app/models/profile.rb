class Profile < ApplicationRecord
    has_one_attached :image
    has_secure_password
     has_many :mobiles 
end
