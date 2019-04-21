class Course < ApplicationRecord
  belongs_to :province
  belongs_to :country
	has_many :tournaments
end
