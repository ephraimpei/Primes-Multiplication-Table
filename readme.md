# Unite US Coding Challenge

## Summary

This program will display a multiplication table of N prime numbers to the console.

## Getting Started
CD into the project directory and run the following command:

    $ ./run_program

## Design

I immediately knew that I would need to create classes `Prime` and `MultiplicationTable` to abstract away these two objects.  I also knew that the `Prime` class wouldn't need to be instantiated because storing `Prime` objects wasn't necessary. Therefore, the class only contains factory methods.  

## Gems
* Byebug - preferred debugger
* Rspec - write test scripts
* Colorize - beautify the console output

## Classes

### Prime

Design
  + The `Prime` class was created with the idea that its sole purpose is to calculate N prime numbers and provide access to retrieve them.  It also exposes the `::is_prime?` factory method to provide on the spot prime number checking.  When invoking the `::calc_nth_prime` factory method, the prime numbers are cached in a class variable such that subsequent calculations of N prime numbers can be done by leveraging the primes that have already been determined.

Performance
  + **Space complexity is O(N)** because the program caches N prime numbers once they are calculated.  **Time complexity is O(m * sqrt(m))** for completely calculating N prime numbers during the worst case scenario (first time calculation, cache is empty) where m is the Nth prime number.

Reasoning

  + N = 10, m = Nth prime number = 29

  + We calculate prime numbers with the factory method `Prime.calc_nth_prime(N)`.  In here, numbers 2 - 29 need to be checked with `Prime.is_prime?(m)` so this brings us to O(m) time complexity.

  + Within the `Prime.is_prime?(m)` factory method, in the worst case we need to check up to the sqrt(m).  Checking any number after the sqrt is actually a duplication of effort (100 divides evenly by 2 and 50; checking 2 is the same as checking 50).

  + `Prime.calc_nth_prime(N)` and the embedded `Prime.is_prime?(m)` check brings our overall time complexity to O(m * sqrt(m)).

### MultiplicationTable

Design

Performance

Reasoning
