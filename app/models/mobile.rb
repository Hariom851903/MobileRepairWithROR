class Mobile < ApplicationRecord
    belongs_to :profile 
    has_many :mobile_problem_lists 
    has_many :problem_lists, through: :mobile_problem_lists  
    has_many :orders 
    has_many :shops, through: :orders  
end  














