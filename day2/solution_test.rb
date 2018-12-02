require "minitest/autorun"
require "./solution.rb"

module Day2
  class SolutionTest < Minitest::Test
    def setup
      @test_input = read_input
    end

    def test_solution
      sample_input = %w(abcdef bababc abbcde abcccd aabcdd abcdee ababab)
      assert_equal Solution.run(sample_input), 12
    end

    def test_solution_with_input
      assert_equal Solution.run(@test_input), 8398
    end

    def test_solution_part_two
      sample_input = %w(abcde fghij klmno pqrst fguij axcye wvxyz)
      assert_equal SolutionPartTwo.run(sample_input), 'fgij'
    end

    def test_solution_part_two_with_input
      assert_equal SolutionPartTwo.run(@test_input), "hhvsdkatysmiqjxunezgwcdpr"
    end

    private

    def read_input
      input = []
      File.open("input", "r") do |f|
        f.each_line do |line|
          input << line.strip
        end
      end

      input
    end
  end
end