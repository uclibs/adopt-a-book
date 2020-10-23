# Product model describes model attributes of products
class Product < ApplicationRecord
  enum adopt_status: %i[available adopted pending]
end
