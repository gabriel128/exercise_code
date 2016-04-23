module Fibo
  module_function

  def factorial(n)
    return n if n == 1
    n * factorial(n - 1)
  end

  def calculate(n, result = [0, 1])
    result[n] = result[n] || calculate(n - 1, result) + calculate(n - 2, result)
  end
end

describe 'Fibo' do
  it 'returns the first 1 values' do
    expect(Fibo.calculate(1)).to eq 1
  end
  it 'returns the first 2 values' do
    expect(Fibo.calculate(2)).to eq 1
  end
  it 'returns the first 3 values' do
    expect(Fibo.calculate(3)).to eq 2
  end
  it 'returns the first 4 values' do
    expect(Fibo.calculate(4)).to eq 3
  end
  it 'returns the first 5 values' do
    expect(Fibo.calculate(5)).to eq 5
  end
  it 'returns the first 6 values' do
    expect(Fibo.calculate(6)).to eq 8
  end
  it 'returns factorial of 6' do
    expect(Fibo.factorial(6)).to eq 720
  end
end
