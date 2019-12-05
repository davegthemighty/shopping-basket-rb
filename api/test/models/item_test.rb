
require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "can save an item" do
    item = Item.new
    assert item.save
  end

  test "item has expected fields" do
      assert_not Item.new.respond_to?('not_a_field')
      assert Item.new.respond_to?('id')
      assert Item.new.respond_to?('name')
      assert Item.new.respond_to?('price')      
  end

end
