require 'minitest/autorun'

# take the n largest values from an unsorted array

class NumberMaster
  def self.give_me_the_largests(of:,  take:)
    of.sort.reverse.uniq.take(take)
  end
end

class LargestNumberTests < Minitest::Test

  def test_return_the_two_larguest_of_an_array
    array = [4, 3, 1, 1, 5]
    assert_equal [5, 4], NumberMaster.give_me_the_largests(of: array, take: 2)
  end

  def test_return_the_five_larguest_of_an_array
    array = [4, 3, 1, 1, 5, 10, 12, 13, 20, 30]
    assert_equal [30, 20, 13, 12, 10], NumberMaster.give_me_the_largests(of: array, take: 5)
  end
end
