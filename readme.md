# Unite US Coding Challenge

## Summary

This program will display a multiplication table of N prime numbers to the console.

![alt text][sample_output]

[sample_output]: https://github.com/ephraimpei/unite-us-coding-challenge/blob/master/images/sample_output.png?raw=true

## Getting Started

CD into the project directory and run the following command:

    $ ./run_program

If you want to determine N yourself, just supply a numerical argument after the command:

    $ ./run_program 20

## Program Design

I immediately knew that I would need to create classes `Prime` and `MultiplicationTable` to abstract away these two objects.  I also knew that the `Prime` class wouldn't need to be instantiated because storing `Prime` objects wasn't necessary. Therefore, the class only contains factory methods one of which allows you to calculate the Nth prime number.

The `MultiplicationTable` class is used to represent the multiplication table.  When this class is instantiated, it will invoke `Prime::calc_nth_prime(N)` where N is the argument provided (N is defaulted to 10).  Instances of the `MultiplicationTable` class will hold values of the multiplication table and a `MultiplicationTable#render` method will be available to STDOUT the table to the console.

## Gems

* Byebug - preferred debugger
* RSpec - write test scripts
* Colorize - beautify the boring console output

## Classes

### Prime

Design

  + The `Prime` class was created with the idea that its sole purpose is to calculate N prime numbers and provide access to retrieve them.  It also exposes the `Prime::is_prime?` factory method to provide on the spot prime number checking.  When invoking the `Prime::calc_nth_prime` factory method, the prime numbers are cached in a class variable such that subsequent calculations of N prime numbers can be done by leveraging the primes that have already been determined.

Performance

  + **Space complexity is O(N)** because the program caches N prime numbers once they are calculated.  **Time complexity is O(m * sqrt(m))** for completely calculating N prime numbers during the worst case scenario (first time calculation, cache is empty) where m is the Nth prime number.

Reasoning

  + N = 10, m = Nth prime number = 29

  + We calculate prime numbers with the factory method `Prime::calc_nth_prime(N)`.  In here, numbers 2 - 29 need to be checked with `Prime::is_prime?(m)` so this brings us to O(m) time complexity.

  + Within the `Prime::is_prime?(m)` factory method, in the worst case we need to check up to the sqrt(m).  Checking any number after the sqrt is actually a duplication of effort (100 divides evenly by 2 and 50; checking 2 is the same as checking 50).

  + `Prime::calc_nth_prime(N)` and the embedded `Prime::is_prime?(m)` check brings our overall time complexity to O(m * sqrt(m)).

Benchmarking

  + To see notes about my benchmarking tests, please see the files within the `benchmark` folder.  To run the tests type in the following command at the project root:

        $ ruby benchmark/prime_benchmark_tests.rb

  + Here were my results of the benchmark tests:

  ![alt text][is_prime_benchmark_tests]

  [is_prime_benchmark_tests]: https://www.github.com/ephraimpei/unite-us-coding-challenge/images/is_prime_benchmark_tests.png

### MultiplicationTable

Design

  + The `MultiplicationTable` class was created such that a multiplication table can be represented as an object.  When instantiated, it can take an argument N (10 by default) which will determine how many prime numbers get calculated.  Also upon instantiation, the `MultiplicationTable#fill_grid` method is invoked to store values of the table in the `@grid` instance variable.  Lastly, the `MultiplicationTable#render` method STDOUTs the table to the console using several helper methods to build the display strings and a neat little gem called `colorize` to sprinkle in some color.

Performance

  + **Space complexity is O(N^2)** because the `@grid` instance variable will grow in both x and y dimensions as the input N gets larger.  **Time complexity is **

Reasoning

Benchmarking

  + To see notes about my benchmarking tests, please see the files within the `benchmark` folder.  To run the tests type in the following command at the project root:

        $ ruby benchmark/mult_table_benchmark_tests.rb

  + Here were my results of the benchmark tests:

  ![alt text][mult_table_benchmark_tests]

  [mult_table_benchmark_tests]: https://www.github.com/ephraimpei/unite-us-coding-challenge/images/mult_table_benchmark_tests.png

## Thanks and I hope you enjoyed my program and documentation!
