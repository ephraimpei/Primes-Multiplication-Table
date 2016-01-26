require_relative "prime"
require 'colorize'
require 'byebug'

class MultiplicationTable
  attr_reader :grid, :dimensions

  def initialize(dimensions = 10)
    Prime.calc_nth_prime(dimensions)

    @dimensions = dimensions
    @grid = fill_grid(dimensions)
  end

  def render
    header_row = build_first_col_el(" ") +
      (1..@dimensions).map{|n| build_display_el(n) }
        .join.colorize(:red) + "\n"

    border_row = "-" * header_row.length + "\n"

    output = header_row + border_row

    (1..@dimensions).each do |row|
      output += build_first_col_el(Prime.get_cached_prime(row))

      color = row.odd? ? :blue : :light_blue

      output += ((1..@dimensions).map do |col|
        build_display_el(@grid[row - 1][col - 1])
      end).join.colorize(color) + "\n"
    end

    print output
  end

  private

  def fill_grid(dimensions)
    grid = Array.new(dimensions) { Array.new(dimensions, nil) }

    # store equivalent expressions.
    # ie: if row = 2, col = 3, prod = 2 * 3 = 6, store [3, 2] = 6
    #     when row = 3, col = 2, can retrieve value from equivalents hash
    equivalents = {}

    0.upto(dimensions - 1) do |row|
      x_prime = Prime.get_cached_prime(row + 1)

      0.upto(dimensions - 1) do |col|
        y_prime = Prime.get_cached_prime(col + 1)

        # store equivalent of [row, col] which is [col, row]
        equivalents[[col, row]] = x_prime * y_prime if col > row

        # retrieve value from equivalents hash if it exists, otherwise calculate
        grid[row][col] = equivalents[[row, col]] ?
          equivalents[[row, col]] :
          x_prime * y_prime
      end
    end

    grid
  end

  def max_product_digits
    max_product = @grid[@dimensions - 1][@dimensions - 1]
    Math.log10(max_product).to_i + 1
  end

  def max_prime_digits
    max_prime = Prime.get_cached_prime(@dimensions)
    Math.log10(max_prime).to_i + 1
  end

  def build_display_el(n)
    " #{ n.to_s.rjust(max_product_digits, " ") } "
  end

  def build_first_col_el(n)
    " #{ n.to_s.rjust(max_prime_digits, " ").colorize(:red) } |"
  end
end
