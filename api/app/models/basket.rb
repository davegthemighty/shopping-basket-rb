class Basket < ApplicationRecord

  validates :total, presence: true, numericality: true

  has_many :items, through: :basket_lines
  has_many :basket_lines
  def get_updated_total
    self.basket_lines.sum { |line| line.item.price  * line.quantity }
  end
end
