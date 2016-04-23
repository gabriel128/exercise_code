require 'minitest/autorun'

module NumberMaster
  module_function

  def sum_squares_of(numbers)
    numbers.map { |number| number * number }.reduce(:+)
  end
end

class SumOfSquaresTests < Minitest::Test
  def test_simple_sum
    assert_equal 5, NumberMaster.sum_squares_of([1, 2])
  end

  def test_three_arg_sum
    assert_equal 21, NumberMaster.sum_squares_of([1, 2, 4])
  end
end
