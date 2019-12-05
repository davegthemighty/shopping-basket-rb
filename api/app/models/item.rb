class Item < ApplicationRecord
  has_many :baskets, through: :basket_lines
  has_many :basket_lines
end
