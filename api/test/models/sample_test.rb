require 'test_helper'

class SampleTest < ActiveSupport::TestCase
  test "cannot save an item without a valid name" do
    sample = Sample.new
    assert_not sample.save
  end
end
