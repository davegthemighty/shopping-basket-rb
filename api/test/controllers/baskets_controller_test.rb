require 'test_helper'

class BasketsControllerTest < ActionDispatch::IntegrationTest
  test "baskets are returned for the get all request" do
     get '/baskets'
     assert_response :success
     assert_equal 0, json_response['baskets'].count

     basket = Basket.new
     basket.total = 0
     assert basket.save

     get '/baskets'
     assert_response :success
     assert_equal 1, json_response['baskets'].count

     basket = Basket.new
     basket.total = 1
     assert basket.save

     get '/baskets'
     assert_response :success
     assert_equal 2, json_response['baskets'].count

     assert_equal "1.0", json_response['baskets'].last['total']

  end

  test "empty basket deletes associated basket lines and sets total to zero" do
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

      delete '/baskets/1/items'
      assert_response :redirect

      basket.basket_lines.reload.empty?

      assert_equal 0, BasketLine.count
      assert_equal 0, basket.get_updated_total

  end

  def json_response
      ActiveSupport::JSON.decode response.body
  end

end
