require 'minitest/autorun'

class NumberMaster
  class << self
    def primes_factors_of(number, factors = [])
      first_factor = first_prime_of number
      second_factor = number / first_factor
      factors << first_factor
      if first_prime_of(second_factor).nil?
        factors << second_factor
        return factors
      else
        primes_factors_of(second_factor, factors)
      end
    end

    private

    def first_prime_of(number)
      (2...number).to_a.detect { |n| number % n == 0 }
    end
  end
end

class NthPrimesFactor < Minitest::Test
  def test_nth_primes_factor_of_75
    assert_equal [3, 5, 5], NumberMaster.primes_factors_of(75)
  end

  def test_nth_primes_factor_of_9
    assert_equal [3, 3], NumberMaster.primes_factors_of(9)
  end

  def test_nth_primes_factor_of_10
    assert_equal [2, 5], NumberMaster.primes_factors_of(10)
  end
end
