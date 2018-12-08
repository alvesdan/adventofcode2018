require "minitest/autorun"
require_relative "./solution.rb"

module Day3
  class SolutionTest < Minitest::Test
    def setup
      @test_input = read_input
    end

    def test_solution
      sample_input = {
        1 => { x: 1, y: 3, w: 4, h: 4 },
        2 => { x: 3, y: 1, w: 4, h: 4 },
        3 => { x: 5, y: 5, w: 2, h: 2 }
      }
      assert_equal Solution.run(sample_input), 4
    end
    
    def test_solution_with_input
      assert_equal Solution.run(@test_input), 105231
    end
    
    def test_solution_with_input_part_two
      assert_equal SolutionPartTwo.run(@test_input), 164
    end
    
    private
    
    def read_input
      input = {}
      File.open("input", "r") do |f|
        f.each_line do |line|
          regex = /\#([0-9]+)\s\@\s([0-9]+)\,([0-9]+)\:\s([0-9]+)x([0-9]+)/
          values = line.strip.scan(regex).first.map { |s| s.to_i }
          id, x, y, w, h = values
          input[id] = { x: x, y: y, w: w, h: h }
        end
      end
      input
    end
  end
end
