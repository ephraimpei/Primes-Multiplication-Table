require_relative "prime"

class MultiplicationTable
  attr_reader :grid
  
  def initialize(dimensions = 10)
    Prime.calc_nth_prime(dimensions)

    @grid = fill_grid(dimensions)
  end

  def render
  end

  private

  def fill_grid(dimensions)
    grid = Array.new(dimensions) { Array.new(dimensions, []) }
    compliments = {}

    0.upto(dimensions - 1) do |row|
      x_prime = Prime.get_cached_prime(row)

      0.upto(dimensions - 1) do |col|
        y_prime = Prime.get_cached_prime(col)

        compliments[[col, row]] = x_prime * y_prime if col > row

        grid[row][col] = compliments[[row, col]] ?
          compliments[[row, col]] :
          x_prime * y_prime
      end
    end
  end

end
