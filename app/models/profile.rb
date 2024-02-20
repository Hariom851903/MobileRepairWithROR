class Profile < ApplicationRecord
    has_secure_password
     has_many :mobiles 
end
