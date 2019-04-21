class Country < ApplicationRecord
	has_many :tours
	has_many :courses
end
