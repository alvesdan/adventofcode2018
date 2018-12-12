require "minitest/autorun"
require_relative "./solution.rb"

module Day1
  class SolutionTest < Minitest::Test
    def setup
      @test_input = read_input
      @sample_input = <<-SAMPLE_INPUT
+1
-2
+3
+1
      SAMPLE_INPUT
    end

    def test_it_can_sum_frequencies
      solution = Solution.new(@sample_input)
      assert_equal solution.frequencies_sum, 3
    end

    def test_solution_with_input
      solution = Solution.new(@test_input)
      assert_equal solution.frequencies_sum, 420
    end

    def test_it_can_find_the_first_common_frequency
      solution = Solution.new("+3\n+3\n+4\n-2\n-4")
      assert_equal solution.first_common_frequency, 10
    end

    def test_solution_part_two_with_input
      solution = Solution.new(@test_input)
      assert_equal solution.first_common_frequency, 227
    end

    private

    def read_input
      File.read("#{__dir__}/input")
    end
  end
end