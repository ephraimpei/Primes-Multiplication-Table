require_relative "../lib/prime"

describe Prime do
  describe "::is_prime" do
    context "if n is a prime number" do
      expected_result = true

      it "returns true when n greater or equal to 2" do
        test_cases = [2, 7, 23, 31, 104729]

        run_is_prime_test_cases(test_cases, expected_result)
      end
    end

    context "if n is not a prime number" do
      expected_result = false

      it "returns false when n is less 2" do
        test_cases = [1, 0, -100]

        run_is_prime_test_cases(test_cases, expected_result)
      end

      it "returns false when n is greater than to 2" do
        test_cases = [4, 25, 1500000]

        run_is_prime_test_cases(test_cases, expected_result)
      end
    end
  end

  describe "::calc_nth_prime" do
    context "takes one parameter and returns the nth prime number" do
      test_cases = [1, 2, 5, 10, 100, 10000]
      expected_results = [2, 3, 11, 29, 541, 104729]

      it "works with caching turned on" do
        caching = true
        run_calc_nth_prime_test_cases(test_cases, expected_results, caching)
      end

      it "works with caching turned off" do
        caching = false
        run_calc_nth_prime_test_cases(test_cases, expected_results, caching)
      end
    end

    it "throws a PrimeException error if parameter is invalid (n < 1)" do
      test_cases = [0, -5, -10, -100]

      test_cases.each_with_index do |n, i|
        puts "\t\ttest case #{i + 1}: n = #{n}"
        expect { Prime.calc_nth_prime(n) }.to raise_error(
          PrimeException, "Can not calculate prime number.")
      end
    end
  end

  describe "::cached_primes" do
    before :each do
      Prime.reset_cache
    end

    context "before running ::calc_nth_prime" do
      it "hasn't cached any values" do
        expect(Prime.cached_primes.keys.length).to equal(0)
      end
    end

    context "after running ::calc_nth_prime once" do
      n = 100

      it "caches all primes up to n (n = #{n})" do
        Prime.calc_nth_prime(n)

        expect(Prime.cached_primes.keys.length).to equal(100)
      end

      it "returns the first through nth prime from the cache" do
        Prime.calc_nth_prime(n)

        test_cases = [0, 1, 10, 100]
        expected_results = [nil, 2, 29, 541]

        test_cases.each_with_index do |n, i|
          puts "\t\ttest case #{i + 1}: n = #{n}"
          expect(Prime.get_cached_prime(n)).to equal(expected_results[i])
        end
      end
    end

    context "after running ::calc_nth_prime more than once" do
      n1, n2 = 50, 150

      it "caches the newly calculated primes" do
        Prime.calc_nth_prime(n1)
        Prime.calc_nth_prime(n2)

        expect(Prime.cached_primes.keys.length).to equal(150)
      end
    end
  end

end

# helper methods

def run_is_prime_test_cases(test_cases, condition)
  test_cases.each_with_index do |n, i|
    puts "\t\ttest case #{i + 1}: n = #{n}"
    expect(Prime.is_prime?(n)).to equal(condition)
  end
end

def run_calc_nth_prime_test_cases(test_cases, expected_results, caching)
  test_cases.each_with_index do |n, i|
    Prime.reset_cache if not caching

    puts "\t\ttest case #{i + 1}: n = #{n}"
    expect(Prime.calc_nth_prime(n)).to equal(expected_results[i])
  end
end
