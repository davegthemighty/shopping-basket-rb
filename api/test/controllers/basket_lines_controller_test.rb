require 'test_helper'

class BasketLinesControllerTest < ActionDispatch::IntegrationTest
  # //Follow Redirect!

  test "add and remove basket line" do

      basket = Basket.new
      basket.id = 1
      basket.total = 0
      assert basket.save

      item = Item.new
      item.id = 1
      item.price = 5.00
      assert item.save

      assert_equal 0, BasketLine.count

      put '/baskets/1/items/1'
      assert_response :redirect

      assert_equal 1, BasketLine.count
      assert_equal 1, BasketLine.first.quantity

      put '/baskets/1/items/1'
      assert_response :redirect

      assert_equal 1, BasketLine.count
      assert_equal 2, BasketLine.first.quantity

      delete '/baskets/1/items/1'
      assert_response :redirect

      assert_equal 1, BasketLine.count
      assert_equal 1, BasketLine.first.quantity

      delete '/baskets/1/items/1'
      assert_response :redirect

      assert_equal 1, BasketLine.count
      assert_equal 0, BasketLine.first.quantity

  end

end
