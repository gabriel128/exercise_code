require 'minitest/autorun'


class AnObject

  def a_method(n)
    recursive_find(n)
  end

  def recursive_find(n, current_number = 2, result = [1])
    return result if result.size == n
    result << current_number if prime?(current_number)
    recursive_find(n, current_number + 1, result)
  end

  def prime?(number, current_divisor = 2, result = [])
    return result.select { |each| each == 0}.size == 1 if result.length == number
    result << number % current_divisor
    prime?(number, current_divisor + 1, result)
  end

  def self.factorial(n)
    return n if n == 1
    n * factorial(n -1)
    # (1..n).inject :*
  end

  def self.fibo(n, result = [0, 1])
    # return [1] if n == 1
    result[n] = result[n] || fibo(n - 1, result) + fibo(n - 2, result)
    # result << result.last(2).inject(:+)
    # fibo(n, result)
  end
end

class PrimeNumbersTests < Minitest::Test

  def test_fibo_5
    assert_equal [1, 2, 3, 5, 8], AnObject.fibo(5)
  end

  def test_factorial
    assert_equal 720, AnObject.factorial(6)
  end

  def test_is_prime
    assert_equal true, AnObject.new.prime?(7)
  end

  def test_11_is_prime
    assert_equal true, AnObject.new.prime?(11)
  end

  def test_10_is_not_prime
    assert_equal false, AnObject.new.prime?(10)
  end

  def test_x
    some_object = AnObject.new
    assert_equal [1], some_object.a_method(1)
  end

  def test_x2
    some_object = AnObject.new
    assert_equal [1, 2], some_object.a_method(2)
  end

  def test_x3
    some_object = AnObject.new
    assert_equal [1, 2, 3], some_object.a_method(3)
  end

  def test_x4
    some_object = AnObject.new
    assert_equal [1, 2, 3, 5, 7, 11], some_object.a_method(6)
  end

end
