require_relative "../../lib/prime"
require_relative "../../lib/mult_table"

describe MultiplicationTable do
  describe "#initialize" do
    it "defaults to 10 X 10 table" do
      mult_table = MultiplicationTable.new

      expect(mult_table.grid.length).to equal(10)
      expect(mult_table.grid.first.length).to equal(10)
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
      mult_table = MultiplicationTable.new

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
          expect(mult_table.grid[row][col]).to equal(expected_result[row][col])
        end
      end
    end
  end

  describe "#render" do
    it "prints to STDOUT"
    it "prints the correct output"
  end

end
