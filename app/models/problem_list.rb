class ProblemList < ApplicationRecord
       has_many :mobile_problem_lists
       has_many :mobiles, through: :mobile_problem_lists
end
