# Unite US Coding Challenge

## Summary

This program will display a multiplication table of N prime numbers to the console.

![alt text][sample_output]

[sample_output]: https://github.com/ephraimpei/unite-us-coding-challenge/blob/master/images/sample_output.png?raw=true

## Getting Started

CD into the project directory and run the following command:

    $ ./run_program

If you want to determine N yourself, just supply an integer argument after the command:

    $ ./run_program 20

## Program Design

I immediately knew that I would need to create classes `Prime` and `MultiplicationTable` to abstract away these two objects.  I also knew that the `Prime` class wouldn't need to be instantiated because storing `Prime` objects wasn't necessary. Therefore, the class only contains factory methods one of which allows you to calculate the Nth prime number.

The `MultiplicationTable` class is used to represent the multiplication table.  When this class is instantiated, it will invoke `Prime::calc_nth_prime(N)` where N is the argument provided (N is defaulted to 10).  Instances of the `MultiplicationTable` class will hold values of the multiplication table and a `MultiplicationTable#render` method will be available to STDOUT the table to the console.

I took the BDD/TDD approach and wrote out the tests before coding the classes.  This allowed me to fully understand what I was building and what functionalities needed to be implemented upfront.  These tests also allowed me to perform regression tests as I was changing the code to make sure nothing got broken.

Lastly, I built the run_program script so the program can be run from the command line.  It has some basic error handling to make sure the supplied input is valid otherwise an exception is raised.

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

  + To run the benchmark tests for the `Prime` class type in the following command at the project root:

        $ ruby benchmark/prime_benchmark_tests.rb

  + Here were my results of the benchmark tests:

  ![alt text][is_prime_benchmark_tests]

  [is_prime_benchmark_tests]: https://github.com/ephraimpei/unite-us-coding-challenge/blob/master/images/is_prime_benchmark_tests.png?raw=true

  + These tests *loosely* confirm that the big O for `Prime::calc_nth_prime` is O(m * sqrt(m))

        test case 1: n = 10000, m = 104729
        t1 = 104729 * Math.sqrt(104729) = 33892252.64

        test case 2: n = 100000, m = 1299709
        t2 = 1299709 * Math.sqrt(1299709) = 1481730393.91

        test case 3: n = 1000000, m = 15485863
        t3 = 15485863 * Math.sqrt(15485863) = 60940093925.69

        test case 4: n = 10000000, m = 179424673
        t4 = 179424673 * Math.sqrt(179424673) = 2403384439866.17

        t4 / t3 = t3 / t2 = t2 / t1 = approx. 40

    As you can see, in each case the total CPU time is expected to increase by a factor of about 40. The data from the benchmark tests show that each run is increasing by a factor of about 32.  

### MultiplicationTable

Design

  + The `MultiplicationTable` class was created such that a multiplication table can be represented as an object.  When instantiated, it can take an argument N (10 by default) which will determine how many prime numbers get calculated.  Also upon instantiation, the `MultiplicationTable#fill_grid` method is invoked to store values of the table in the `@grid` instance variable.  Lastly, the `MultiplicationTable#render` method STDOUTs the table to the console using several helper methods to build the display strings and a neat little gem called `colorize` to sprinkle in some color.

Performance

  + **Space complexity is O(N^2)** because the `@grid` instance variable will grow in both x and y dimensions as the input N gets larger.  **Time complexity to fill `@grid` is also O(N^2).** (See reasoning below).

  + Overall, the total time to instantiate a `MultiplicationTable` object in the worst case (Prime cache is empty, calculating Primes for the first time) is **O(N^2) + O(m * sqrt(m))** where N is the number of primes and m is the Nth prime. However, at scale O(N^2) will overshadow O(m * sqrt(m)) therefore the time complexity is just **O(N^2)**.

Reasoning

  + Without the known expressions optimization, the `MultiplicationTable#fill_grid` is simply a double nested loop which has a time complexity of O(N^2).  All double nested loops share this same time complexity.  I knew this was no good so I attempted to look for a pattern and noticed that known expressions can be stored and retrieved once the algorithm comes to those expressions:

  ![alt text][mult_table_pattern_screenshot]

  The cells highlighted in orange are retrieved from the known expressions hash while the cells highlighted in blue are the ones that are actually searched and calculated.

  [mult_table_pattern_screenshot]: https://github.com/ephraimpei/unite-us-coding-challenge/blob/master/images/mult_table_pattern_screenshot.png?raw=true

  + This eliminates almost half of the expressions that need to be searched and evaluated.  However, as mentioned earlier the time complexity of the algorithm is still growing exponentially.

  + Despite attempts to optimize the `MultiplicationTable#fill_grid` method, the algorithm still averages out to O(N^2) because the optimization is overshadowed by the exponential at scale. The optimization brings the time complexity to O(N * (N-1)) which factors out to become O(N^2 - N) which becomes O(N^2) at scale.

Benchmarking

  + To run the benchmark tests for the `MultiplicationTable` class type in the following command at the project root:

        $ ruby benchmark/mult_table_benchmark_tests.rb

  + Here were my results of the benchmark tests:

  ![alt text][mult_table_benchmark_tests]

  [mult_table_benchmark_tests]: https://github.com/ephraimpei/unite-us-coding-challenge/blob/master/images/mult_table_benchmark_tests.png?raw=true

  + You can clearly see that the run times are increasing exponentially after each test case.

## Thanks and I hope you enjoyed my program and documentation!
