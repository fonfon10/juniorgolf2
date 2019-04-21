class Tour < ApplicationRecord
	belongs_to :country
	has_many :tournaments
end
