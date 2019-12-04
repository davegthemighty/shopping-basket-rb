class Item < ApplicationRecord
  has_many :basket_lines, inverse_of: :basket
end
