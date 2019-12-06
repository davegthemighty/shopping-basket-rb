require 'test_helper'

class SampleTest < ActiveSupport::TestCase
  test "cannot save a sample model without a valid name" do
    sample = Sample.new
    assert_not sample.save
  end

  test "name is a required field for sample model" do
    sample = Sample.new

    assert_not sample.valid?

    assert_equal sample.errors[:name], ["can't be blank", "is too short (minimum is 3 characters)"]

    sample.name = 'te'
    assert_not sample.valid?

  end

  test "name must be at least three characters" do
    sample = Sample.new
    sample.name = 'te'

    assert_not sample.valid?

    assert_equal sample.errors[:name], ["is too short (minimum is 3 characters)"]

    sample.name = 'tea'
    assert sample.valid?

  end


end
