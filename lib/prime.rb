class PrimeException < StandardError
end

class Prime
  @@cached_primes = {}

  def self.cached_primes
    @@cached_primes
  end

  def self.get_cached_prime(n)
    @@cached_primes[n]
  end

  def self.reset_cache
    @@cached_primes = {}
  end

  # Time complexity = O(m * sqrt(m)) where m is the nth prime number
  # ex: n = 10, m = 29 since numbers 2 - 29 need to be checked with ::is_prime?
  # Space complexity = O(n)
  def self.calc_nth_prime(n)
    raise PrimeException.new("Can not calculate prime number.") if n < 1

    # return prime if it has been cached
    return @@cached_primes[n] if @@cached_primes[n]

    # start counting primes from the last prime that was cached
    prime_counter = @@cached_primes.keys.length

    # set current value equal to last cached prime + 1 or 2 if is cache empty
    current_num = prime_counter == 0 ? 2 : @@cached_primes[prime_counter] + 1

    while prime_counter < n
      if Prime.is_prime?(current_num)
        prime_counter += 1

        # cache prime
        @@cached_primes[prime_counter] = current_num
      end

      current_num += 1
    end

    @@cached_primes[n]
  end

  # Time complexity = O(sqrt(n))
  # Space complexity = O(1)
  def self.is_prime?(n)
    # n == 2 check needed to allow even number check to work
    return true if n == 2

    # return false if n is even or less than 2
    return false if n % 2 == 0 || n < 2

    # no need to check numbers after sqrt of n
    limit = Math.sqrt(n)

    # return false if sqrt is a multiple
    return false if limit % limit.to_i == 0

    # floor limit for iteration
    limit = limit.to_i

    2.upto(limit) { |i| return false if n % i == 0 }

    true
  end
end
