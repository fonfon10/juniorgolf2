class Competition < ApplicationRecord

belongs_to :tournament
belongs_to :status
belongs_to :user

end
