require_relative "../lib/prime"
require "benchmark"

is_prime_test_cases = [1000001, 10000001, 100000001, 1000000001]
calc_nth_prime_test_cases = [1000, 10000, 100000, 1000000, 10000000]

puts "Prime::is_prime? tests"

Benchmark.bm(14) do |x|
  is_prime_test_cases.each do |m|
    x.report("m = #{m}") { Prime.is_prime?(m) }
  end
end

puts "\n"

puts "Prime::calc_nth_prime tests"

Benchmark.bm(14) do |x|
  calc_nth_prime_test_cases.each do |n|
    x.report("n = #{n}") { Prime.calc_nth_prime(n) }
  end
end
