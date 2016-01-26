require_relative "../lib/prime"
require "benchmark"

is_prime_test_cases = [1000001, 10000001, 100000001, 1000000001]
calc_nth_prime_test_cases = [1000, 10000, 100000, 1000000, 10000000]


puts "Prime.is_prime? tests"

# These tests cranked out remarkably faster than I thought
# Wasn't able to get a benchmark that proves the O(sqrt(m)) time complexity
# since every test completed almost instantaneously!

Benchmark.bm(14) do |x|
  is_prime_test_cases.each do |m|
    x.report("m = #{m}") { Prime.is_prime?(m) }
  end
end

puts "\n"

puts "Prime.calc_nth_prime tests"

# These tests absolutely confirm that the big O for this task is O(m * sqrt(m))
# Each test increased the total CPU time by a factor of 31.62
# Observe:
#   test case 1: m = 10000 (increased by factor of 10)
#     t1 = 10000 * Math.sqrt(10000) = 1000000.0
#   test case 2: m = 100000 (increased by factor of 10)
#     t2 = 100000 * Math.sqrt(100000) = 31622776.60
#   test case 3: m = 1000000 (increased by factor of 10)
#     t3 = 1000000 * Math.sqrt(1000000) = 1000000000.0
#   test case 4: m = 1000000 (increased by factor of 10)
#     t4 = 10000000 * Math.sqrt(10000000) = 31622776601.68
#
#   t4 / t3 = t3 / t2 = t2 / t1 = 31.62

Benchmark.bm(14) do |x|
  calc_nth_prime_test_cases.each do |n|
    x.report("n = #{n}") { Prime.calc_nth_prime(n) }
  end
end
