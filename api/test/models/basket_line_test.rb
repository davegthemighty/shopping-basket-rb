
require 'test_helper'

class BasketLineTest < ActiveSupport::TestCase

  test "basket line has expected fields" do
      assert_not BasketLine.new.respond_to?('not_a_field')
      assert BasketLine.new.respond_to?('basket_id')
      assert BasketLine.new.respond_to?('item_id')
      assert BasketLine.new.respond_to?('quantity')
  end

  test "basket line quantity must be an integer" do
      basket_line = BasketLine.new

      assert_not basket_line.valid?
      assert_not_nil basket_line.errors[:quantity]
      assert_equal basket_line.errors[:quantity], ["can't be blank", "is not a number"]

      basket_line.quantity = 'jim'
      assert_not basket_line.valid?

      assert_equal basket_line.errors[:quantity], ["is not a number"]

      basket_line.quantity = 1
      assert_not basket_line.valid?
      assert_equal basket_line.errors[:quantity], []

      basket_line.quantity = 1.99
      assert_not basket_line.valid?
      assert_equal basket_line.errors[:quantity], ["must be an integer"]

  end

  test "basket line item must exist" do
      basket_line = BasketLine.new

      assert_not basket_line.valid?
      assert_not_nil basket_line.errors[:item]
      assert_equal basket_line.errors[:item], ["must exist"]

      item = Item.new
      basket_line.item = item

      assert_not basket_line.valid?
      assert_equal basket_line.errors[:item], []
  end

  test "basket line basket must exist" do
      basket_line = BasketLine.new

      assert_not basket_line.valid?
      assert_not_nil basket_line.errors[:basket]
      assert_equal basket_line.errors[:basket], ["must exist"]

      basket = Basket.new
      basket_line.basket = basket

      assert_not basket_line.valid?
      assert_equal basket_line.errors[:basket], []
  end

  test "save valid basket line" do
      basket_line = BasketLine.new

      assert_not basket_line.valid?
      assert_not basket_line.save

      basket_line.basket = Basket.new
      assert_not basket_line.valid?
      assert_not basket_line.save

      basket_line.item = Item.new
      assert_not basket_line.valid?
      assert_not basket_line.save

      basket_line.quantity = 5
      assert basket_line.valid?
      assert basket_line.save
  end

end
