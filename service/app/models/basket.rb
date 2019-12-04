class Basket < ApplicationRecord
  has_many :basket_lines, inverse_of: :item
end
