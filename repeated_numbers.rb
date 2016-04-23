require 'minitest/autorun'

# take a collection of integers and produce a collection of all ints that
# appear more than once

class NumberMaster
  def self.give_me_the_repeated_of(an_array)
    tmp_array = an_array.clone
    tmp_array.each.with_index.reduce([]) do |result, (number, index)|
      tmp_array.delete_at(index)
      unless result.include? number
        finding = tmp_array.find { |n| n == number }
        result << finding if finding
      end
      result
    end
  end
end

class RepeatedNumbersTests < Minitest::Test

  def test_1_appears_multiple_times
    array = [1, 2, 1, 3]
    assert_equal [1], NumberMaster.give_me_the_repeated_of(array)
  end

  def test_1_and_2_appears_multiple_times
    array = [1, 2, 1, 3, 2, 2, 4]
    assert_equal [1, 2], NumberMaster.give_me_the_repeated_of(array)
  end

  def test_method_does_not_modify_array
    array = [1, 2, 1, 3]
    NumberMaster.give_me_the_repeated_of(array)
    assert_equal array.size, 4
  end
end
