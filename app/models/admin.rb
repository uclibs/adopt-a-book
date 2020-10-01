# Admin class manages admin part of the application including login, logout and register
class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates_presence_of :email, :password
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, timeout_in: 30.seconds
end
