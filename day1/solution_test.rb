require "minitest/autorun"
require "./solution.rb"

module Day1
  class SolutionTest < Minitest::Test
    def setup
      @test_input = read_input
    end

    def test_solution
      assert_equal Solution.run([]), 0
      assert_equal Solution.run([+1, -2, +3, +1]), 3
      assert_equal Solution.run([+1, -1]), 0
      assert_equal Solution.run([+1, +1]), 2
      refute_equal Solution.run([+1, +1]), 3
    end

    def test_solution_with_input
      assert_equal Solution.run(@test_input), 420
    end

    def test_solution_part_two
      assert_equal SolutionPartTwo.run([+1, -1]), 0
      assert_equal SolutionPartTwo.run([+3, +3, +4, -2, -4]), 10
      assert_equal SolutionPartTwo.run([-6, +3, +8, +5, -6]), 5
      assert_equal SolutionPartTwo.run([+7, +7, -2, -7, -4]), 14
    end

    def test_solution_part_two_with_input
      assert_equal SolutionPartTwo.run(@test_input), 227
    end

    private

    def read_input
      input = []
      File.open("input", "r") do |f|
        f.each_line do |line|
          input << Integer(line)
        end
      end

      input
    end
  end
end