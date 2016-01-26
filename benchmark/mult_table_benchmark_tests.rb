require_relative "../lib/mult_table"
require "benchmark"

test_cases = [100, 1000, 10000]

puts "MultiplicationTable#initialize (#fill_grid) test #1"
puts "Prime cache is cleared and Prime::calc_nth_prime is run before each test case"
puts "to ensure we are measuring MultiplicationTable#fill_grid alone"
puts "\n"

Benchmark.bm(12) do |x|
  test_cases.each do |n|
    Prime.reset_cache
    Prime.calc_nth_prime(n)

    # Prime::calc_nth_prime will still run with each instantiation, but
    # values are already cached so runtime is expected to be instantaneous
    x.report("n = #{n}") { MultiplicationTable.new(n) }
  end
end

puts "\n"

puts "MultiplicationTable#initialize (#fill_grid) test #2"
puts "Prime cache is cleared before running each test case"
puts "to ensure we are measuring the total time for"
puts "MultiplicationTable#fill_grid + Prime::calc_nth_prime"
puts "\n"

Benchmark.bm(12) do |x|
  test_cases.each do |n|
    Prime.reset_cache

    # Prime::calc_nth_prime will run with each instantiation, but this time
    # nothing is cached so we will get the full runtime.
    x.report("n = #{n}") { MultiplicationTable.new(n) }
  end
end
