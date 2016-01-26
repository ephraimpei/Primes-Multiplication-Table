require_relative "../lib/prime"
require_relative "../lib/mult_table"

describe MultiplicationTable do
  before :each do
    @mult_table = MultiplicationTable.new
  end

  describe "#initialize" do
    it "defaults to 10 X 10 table" do
      expect(@mult_table.grid.length).to equal(10)
      expect(@mult_table.grid.first.length).to equal(10)
    end

    it "takes an argument N and creates an N X N table" do
      test_cases = [5, 8, 15, 20]

      test_cases.each_with_index do |n, i|
        puts "\t\ttest case #{i + 1}: n = #{n}"
        mult_table = MultiplicationTable.new(n)
        expect(mult_table.grid.length).to equal(n)
        expect(mult_table.grid.first.length).to equal(n)
      end
    end

    it "correctly populates the table with the products of prime numbers" do
      expected_result = [
        [4, 6, 10, 14, 22, 26, 34, 38, 46, 58],
        [6, 9, 15, 21, 33, 39, 51, 57, 69, 87],
        [10, 15, 25, 35, 55, 65, 85, 95, 115, 145],
        [14, 21, 35, 49, 77, 91, 119, 133, 161, 203],
        [22, 33, 55, 77, 121, 143, 187, 209, 253, 319],
        [26, 39, 65, 91, 143, 169, 221, 247, 299, 377],
        [34, 51, 85, 119, 187, 221, 289, 323, 391, 493],
        [38, 57, 95, 133, 209, 247, 323, 361, 437, 551],
        [46, 69, 115, 161, 253, 299, 391, 437, 529, 667],
        [58, 87, 145, 203, 319, 377, 493, 551, 667, 841]
      ]

      0.upto(9) do |row|
        0.upto(9) do |col|
          expect(@mult_table.grid[row][col]).to equal(expected_result[row][col])
        end
      end
    end
  end

  describe "#render" do
    it "prints to STDOUT" do
      expect { @mult_table.render }.to output.to_stdout
    end

    it "prints the correct output" do
      expected_output = "    |   2    3    5    7   11   13   17   19   23   29 \n--------------------------------------------------------\n  2 |\e[0;33;49m   4 \e[0m\e[0;34;49m   6 \e[0m\e[0;34;49m  10 \e[0m\e[0;34;49m  14 \e[0m\e[0;34;49m  22 \e[0m\e[0;34;49m  26 \e[0m\e[0;34;49m  34 \e[0m\e[0;34;49m  38 \e[0m\e[0;34;49m  46 \e[0m\e[0;34;49m  58 \e[0m\n  3 |\e[0;31;49m   6 \e[0m\e[0;33;49m   9 \e[0m\e[0;31;49m  15 \e[0m\e[0;31;49m  21 \e[0m\e[0;31;49m  33 \e[0m\e[0;31;49m  39 \e[0m\e[0;31;49m  51 \e[0m\e[0;31;49m  57 \e[0m\e[0;31;49m  69 \e[0m\e[0;31;49m  87 \e[0m\n  5 |\e[0;34;49m  10 \e[0m\e[0;34;49m  15 \e[0m\e[0;33;49m  25 \e[0m\e[0;34;49m  35 \e[0m\e[0;34;49m  55 \e[0m\e[0;34;49m  65 \e[0m\e[0;34;49m  85 \e[0m\e[0;34;49m  95 \e[0m\e[0;34;49m 115 \e[0m\e[0;34;49m 145 \e[0m\n  7 |\e[0;31;49m  14 \e[0m\e[0;31;49m  21 \e[0m\e[0;31;49m  35 \e[0m\e[0;33;49m  49 \e[0m\e[0;31;49m  77 \e[0m\e[0;31;49m  91 \e[0m\e[0;31;49m 119 \e[0m\e[0;31;49m 133 \e[0m\e[0;31;49m 161 \e[0m\e[0;31;49m 203 \e[0m\n 11 |\e[0;34;49m  22 \e[0m\e[0;34;49m  33 \e[0m\e[0;34;49m  55 \e[0m\e[0;34;49m  77 \e[0m\e[0;33;49m 121 \e[0m\e[0;34;49m 143 \e[0m\e[0;34;49m 187 \e[0m\e[0;34;49m 209 \e[0m\e[0;34;49m 253 \e[0m\e[0;34;49m 319 \e[0m\n 13 |\e[0;31;49m  26 \e[0m\e[0;31;49m  39 \e[0m\e[0;31;49m  65 \e[0m\e[0;31;49m  91 \e[0m\e[0;31;49m 143 \e[0m\e[0;33;49m 169 \e[0m\e[0;31;49m 221 \e[0m\e[0;31;49m 247 \e[0m\e[0;31;49m 299 \e[0m\e[0;31;49m 377 \e[0m\n 17 |\e[0;34;49m  34 \e[0m\e[0;34;49m  51 \e[0m\e[0;34;49m  85 \e[0m\e[0;34;49m 119 \e[0m\e[0;34;49m 187 \e[0m\e[0;34;49m 221 \e[0m\e[0;33;49m 289 \e[0m\e[0;34;49m 323 \e[0m\e[0;34;49m 391 \e[0m\e[0;34;49m 493 \e[0m\n 19 |\e[0;31;49m  38 \e[0m\e[0;31;49m  57 \e[0m\e[0;31;49m  95 \e[0m\e[0;31;49m 133 \e[0m\e[0;31;49m 209 \e[0m\e[0;31;49m 247 \e[0m\e[0;31;49m 323 \e[0m\e[0;33;49m 361 \e[0m\e[0;31;49m 437 \e[0m\e[0;31;49m 551 \e[0m\n 23 |\e[0;34;49m  46 \e[0m\e[0;34;49m  69 \e[0m\e[0;34;49m 115 \e[0m\e[0;34;49m 161 \e[0m\e[0;34;49m 253 \e[0m\e[0;34;49m 299 \e[0m\e[0;34;49m 391 \e[0m\e[0;34;49m 437 \e[0m\e[0;33;49m 529 \e[0m\e[0;34;49m 667 \e[0m\n 29 |\e[0;31;49m  58 \e[0m\e[0;31;49m  87 \e[0m\e[0;31;49m 145 \e[0m\e[0;31;49m 203 \e[0m\e[0;31;49m 319 \e[0m\e[0;31;49m 377 \e[0m\e[0;31;49m 493 \e[0m\e[0;31;49m 551 \e[0m\e[0;31;49m 667 \e[0m\e[0;33;49m 841 \e[0m\n"

      expect { @mult_table.render }.to output(expected_output).to_stdout
    end
  end

end
