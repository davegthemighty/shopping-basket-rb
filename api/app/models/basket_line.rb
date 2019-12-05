class BasketLine < ApplicationRecord

  validates :quantity, presence: true, numericality: { only_integer: true }

  belongs_to :item
  belongs_to :basket
end
