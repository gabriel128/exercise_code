require 'minitest/autorun'

# take a collection of integers and produce a collection of all ints that
# appear more than once

module NumberMaster
  module_function

  def repeated_numbers_of(array)
    array_cp = array.clone
    array.reduce([]) do |result, number|
      array_cp.delete_at(0)
      result << number if array_cp.include? number
      result
    end.uniq.sort
  end
end

class RepeatedNumbersTest < Minitest::Test
  def test_it_returns_ones
    assert_equal [1], NumberMaster.repeated_numbers_of([1, 1, 2])
  end

  def test_it_return_one_and_two
    assert_equal [1, 2], NumberMaster.repeated_numbers_of([1, 1, 2, 2])
  end

  def test_it_return_one_and_two_three
    assert_equal [1, 2, 3], NumberMaster.repeated_numbers_of([1, 1, 2, 2, 3, 3, 3])
  end

  def test_it_returns_repeated_in_any_order_given
    assert_equal [1, 2], NumberMaster.repeated_numbers_of([2, 3, 2, 1, 2, 1])
  end
end
