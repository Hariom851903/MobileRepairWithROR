
class Mobile < ApplicationRecord
    belongs_to :profile 
    has_many :mobile_problem_lists 
    has_many :objects, through: :mobile_problem_lists
end
