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

  def json_response
      ActiveSupport::JSON.decode response.body
  end

end
