# Adopter model defines the relationship between products and adopters
class Adopter < ApplicationRecord
  has_many :products, dependent: :nullify
end
