require 'minitest/autorun'

class BinarySearcher
  def self.find(number:, from:)
    if from.length == 2
      return from.select { |n| n == number }.first
    end
    sorted_array = from.sort
    array_first_half = sorted_array.slice(0, sorted_array.length / 2)
    array_second_half = sorted_array.slice(sorted_array.length / 2, sorted_array.length - 1)
    if array_first_half.last == number
      return number
    elsif array_first_half.last > number
      find(number: number, from: array_first_half)
    else
      find(number: number, from: array_second_half)
    end
  end
end

class BinarySearchTests < Minitest::Test
  def test_find_a_number_in_small_odd_array
    array = [1, 6, 3, 5, 7, 2, 8]
    assert_equal 5, BinarySearcher.find(number: 5, from: array)
  end

  def test_find_a_number_in_small_even_array
    array = [1, 6, 3, 5, 7, 2, 8, 16]
    assert_equal 2, BinarySearcher.find(number: 2, from: array)
  end
end
