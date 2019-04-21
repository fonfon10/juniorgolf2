class Tournament < ApplicationRecord
	belongs_to :tour 
	belongs_to :course 
	belongs_to :level 

	has_many :competitions	




end
