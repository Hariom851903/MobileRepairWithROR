class Shop < ApplicationRecord
    has_secure_password
    belongs_to :profile
end
