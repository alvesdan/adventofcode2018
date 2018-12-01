require "minitest/autorun"
require "./solution.rb"

module Day1
  class SolutionTest < Minitest::Test
    def setup
      @test_input = read_input
    end

    def test_solution
      assert_equal Solution.run([+1, -2, +3, +1]), 3
      assert_equal Solution.run([+1, -1]), 0
      assert_equal Solution.run([+1, +1]), 2
    end

    def test_wrong_input
      refute_equal Solution.run([+1, +1]), 3
    end

    def test_big_input
      assert_equal Solution.run(@test_input), 420
    end

    def test_solution_two
      assert_equal Solution.run_two([+1, -1]), 0
      assert_equal Solution.run_two([+3, +3, +4, -2, -4]), 10
      assert_equal Solution.run_two([-6, +3, +8, +5, -6]), 5
      assert_equal Solution.run_two([+7, +7, -2, -7, -4]), 14
    end

    def test_solution_two_big
      assert_equal Solution.run_two(@test_input), 227
    end

    private

    def read_input
      input = []
      File.open("input.txt", "r") do |f|
        f.each_line do |line|
          input << Integer(line)
        end
      end

      input
    end
  end
end