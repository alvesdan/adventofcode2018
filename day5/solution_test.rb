require "minitest/autorun"
require_relative "./solution.rb"

module Day5
  class SolutionTest < Minitest::Test
    def setup
      @test_input = read_input
    end

    def test_it_can_recognize_reaction
      solution = Solution.new("")
      assert_equal solution.opposite_polarity?("a", "A"), true
      assert_equal solution.opposite_polarity?("A", "a"), true
      assert_equal solution.opposite_polarity?("a", "a"), false
      assert_equal solution.opposite_polarity?("a", "b"), false
    end

    def test_it_can_remove_reacting_units
      solution = Solution.new("")
      assert_equal solution.remove_reacting_units("dabAcCaCBAcCcaDA"), "dabCBAcaDA"
    end

    def test_it_can_solve_part_one
      solution = Solution.new("dabAcCaCBAcCcaDA")
      assert_equal solution.part_one, 10
    end

    def test_it_can_solve_part_one_with_input
      solution = Solution.new(@test_input)
      assert_equal solution.part_one, 9078
    end

    def test_it_can_remove_units_of_same_type
      solution = Solution.new("")
      assert_equal solution.remove_units_of_same_type("dabAcCaCBAcCcaDA", "a"), "dbcCCBcCcD"
    end

    def test_it_can_find_all_available_units
      solution = Solution.new("")
      assert_equal solution.available_units("dabAcCaCBAcCcaDA"), %w(d a b c)
    end

    def test_it_can_solve_part_two
      solution = Solution.new("dabAcCaCBAcCcaDA")
      assert_equal solution.part_two, 4
    end

    def test_it_can_solve_part_two_with_input
      solution = Solution.new(@test_input)
      assert_equal solution.part_two, 5698
    end

    private

    def read_input
      File.read("#{__dir__}/input")
    end
  end
end