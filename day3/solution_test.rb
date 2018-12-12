require "minitest/autorun"
require_relative "./solution.rb"

module Day3
  class SolutionTest < Minitest::Test
    def setup
      @test_input = read_input
      @sample_input = <<-SAMPLE_INPUT
#1 @ 1,3: 4x4
#2 @ 3,1: 4x4
#3 @ 5,5: 2x2
      SAMPLE_INPUT
    end

    def test_it_can_parse_input
      solution = Solution.new(@sample_input)
      assert_equal solution.claims, {
        1 => { x: 1, y: 3, w: 4, h: 4 },
        2 => { x: 3, y: 1, w: 4, h: 4 },
        3 => { x: 5, y: 5, w: 2, h: 2 }
      }
    end

    def test_it_can_find_inches_with_more_than_one_claim
      assert_equal Solution.new(@sample_input).inches_with_multiple_claims, 4
    end

    def test_it_can_find_solution_with_input
      assert_equal Solution.new(@test_input).inches_with_multiple_claims, 105231
    end

    def test_it_can_find_solution_part_two_with_input
      assert_equal Solution.new(@test_input).claim_without_overlap, 164
    end

    private

    def read_input
      File.read("#{__dir__}/input")
    end
  end
end
