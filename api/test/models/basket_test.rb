
require 'test_helper'

class BasketTest < ActiveSupport::TestCase
  test "cannot save a basket without a total" do
    basket = Basket.new
    assert_not basket.save
  end

  test "can save a basket with a valid total" do
    basket = Basket.new
    basket.total = 1
    assert basket.save
  end

  test "cannot save a basket with a non-numeric total" do
    basket = Basket.new
    basket.total = 'jim'
    assert_not basket.save
  end

  test "basket has expected fields" do
      assert_not Basket.new.respond_to?('not_a_field')
      assert Basket.new.respond_to?('id')
      assert Basket.new.respond_to?('total')
  end

  test "basket update calculates totals from basket lines with one item" do
      basket = Basket.new
      basket.id = 1
      basket.total = 0
      assert basket.save

      item = Item.new
      item.id = 1
      item.price = 5.00
      assert item.save

      assert_equal basket.get_updated_total, 0

      basket_line = BasketLine.new(:basket_id => basket.id, :item_id => item.id, :quantity => 1)
      assert basket_line.save

      basket.basket_lines.reload.empty?

      assert_equal 5.00, basket.get_updated_total

      basket_line.update(:quantity => 2)
      assert basket_line.save

      basket.basket_lines.reload.empty?

      assert_equal 10.00, basket.get_updated_total

  end

  test "basket update calculates totals from basket lines with two items" do
      basket = Basket.new
      basket.id = 1
      basket.total = 0
      assert basket.save

      item_one = Item.new
      item_one.id = 1
      item_one.price = 5.00
      assert item_one.save

      item_two = Item.new
      item_two.id = 2
      item_two.price = 3.99
      assert item_two.save

      assert_equal basket.get_updated_total, 0

      basket_line_one = BasketLine.new(:basket_id => basket.id, :item_id => item_one.id, :quantity => 1)
      assert basket_line_one.save

      basket_line_two = BasketLine.new(:basket_id => basket.id, :item_id => item_two.id, :quantity => 1)
      assert basket_line_two.save

      basket.basket_lines.reload.empty?

      assert_equal 8.99, basket.get_updated_total

      basket_line_two.update(:quantity => 2)
      assert basket_line_two.save

      basket.basket_lines.reload.empty?

      assert_equal 12.98, basket.get_updated_total

  end

end
