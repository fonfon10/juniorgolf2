class Tournament < ApplicationRecord
	belongs_to :tour 
	belongs_to :course 
	belongs_to :level 
	belongs_to :user

	has_many :competitions	




end
