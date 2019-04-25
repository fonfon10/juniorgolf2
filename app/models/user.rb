class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  belongs_to :user_type

  has_many :competitions
  has_many :tournaments


  validates_presence_of :first_name, :last_name, :email
  
end
