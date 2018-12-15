require "minitest/autorun"
require_relative "./solution.rb"

<<-DOC
1. Hash with all axis (x, y) - to make lookup faster - Done
2. Store coordinations - Done
3. For each coordinate check if it is finity:
    a. any other coordinate has a higher or lower x axis
    b. any other coordinate has a higher or lower y axis
4. Calculate number of locations closer to finity coordinates
DOC

module Day6
  class SolutionTest < Minitest::Test
    def setup
      @test_input = read_input
      @sample_input = <<-SAMPLE_INPUT
1, 1
1, 6
8, 3
3, 4
5, 5
8, 9
      SAMPLE_INPUT
      @sample_solution = Solution.new(@sample_input)
    end

    def test_it_can_parse_input
      assert_equal @sample_solution.coordinates, [
        [1, 1],
        [1, 6],
        [8, 3],
        [3, 4],
        [5, 5],
        [8, 9]
      ]
    end
    
    def test_it_can_find_manhattan_distance_between_positions
      a = [3, 4]
      b = [5, 5]
      assert_equal @sample_solution.manhattan_distance(a, b), 3
    end
    
    def test_it_can_find_coordinates_distances_to_positions
      assert_equal @sample_solution.closest_locations_for([3, 4]), 9
      assert_equal @sample_solution.closest_locations_for([5, 5]), 17
    end
    
    def test_it_can_solve_part_one
      assert_equal @sample_solution.part_one, 17
    end
    
    def test_it_can_solve_part_one_with_input
      solution = Solution.new(@test_input)
      assert_equal solution.part_one, 4589
    end
    
    def test_it_can_solve_part_two
      assert_equal @sample_solution.part_two, 100
    end
    
    def test_it_can_solve_part_two_with_input
      solution = Solution.new(@test_input)
      assert_equal solution.part_two, 40252
    end
    
    private

    def read_input
      File.read("#{__dir__}/input")
    end
  end
end
