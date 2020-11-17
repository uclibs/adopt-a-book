# Adopter model defines the relationship between products and adopters
class Adopter < ApplicationRecord
  has_many :products, dependent: :nullify
  validates_uniqueness_of :email, scope: %i[fname lname address phone]
end
