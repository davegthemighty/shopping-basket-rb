require 'test_helper'

class SampleTest < ActiveSupport::TestCase
  test "cannot save a sample model without a valid name" do
    sample = Sample.new
    assert_not sample.save
  end

  test "name is a required field for sample model" do
    sample = Sample.new

    assert_not sample.valid?

    assert_equal sample.errors[:name], ["can't be blank"]

    sample.name = 'te'
    assert sample.valid?

  end

end
