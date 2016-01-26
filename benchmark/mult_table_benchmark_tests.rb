require_relative "../lib/mult_table"
require "benchmark"

test_cases = [100]

puts "MultiplicationTable#initialize (#fill_grid) tests"
puts "Prime cache is cleared and Prime::calc_nth_prime is run before each test"
puts "to ensure we are measuring MultiplicationTable#fill_grid alone"

Benchmark.bm(14) do |x|
  test_cases.each do |n|
    # reset set the cache and calc the prime values before running tests
    # want to measure time of MultiplicationTable#fill_grid not Prime::calc_nth_prime
    Prime.reset_cache
    Prime.calc_nth_prime(n)

    # Prime#calc_nth_prime will still run with each instantiation, but
    # values are already cached so runtime is expected to be instantaneous
    x.report("n = #{n}") { MultiplicationTable.new(n) }
  end
end
