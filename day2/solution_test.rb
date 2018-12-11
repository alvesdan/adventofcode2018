require "minitest/autorun"
require "./solution.rb"

module Day2
  class SolutionTest < Minitest::Test
    def setup
      @test_input = read_input
      @sample_input = <<-SAMPLE_INPUT
abcdef
bababc
abbcde
abcccd
aabcdd
abcdee
ababab
      SAMPLE_INPUT

      @sample_input_diff = <<-SAMPLE_INPUT
abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz
      SAMPLE_INPUT
    end

    def test_it_can_parse_input
      solution = Solution.new(@sample_input)
      assert_equal solution.boxes.first, "abcdef"
    end

    def test_it_can_count_the_amount_of_letters_in_a_string
      solution = Solution.new(@sample_input)
      assert_equal solution.amount_of_letters_for("bababc"), {
        "b" => 3,
        "a" => 2,
        "c" => 1
      }
    end

    def test_it_can_count_words_with_two_and_three_letters_occurrency
      solution = Solution.new(@sample_input)
      assert_equal solution.words_with_two_and_three_letters_occurrency, {
        2 => 4,
        3 => 3
      }
    end

    def test_solution
      solution = Solution.new(@sample_input)
      assert_equal solution.part_one, 12
    end

    def test_solution_with_input
      solution = Solution.new(@test_input)
      assert_equal solution.part_one, 8398
    end

    def test_it_can_find_the_difference_and_matched_letters
      solution = Solution.new(@sample_input_diff)
      a = %w(f g h i j)
      b = %w(f g u i j)
      assert_equal solution.difference_and_matched_letters(a, b), [1, "fgij"]
    end

    def test_solution_part_two
      solution = Solution.new(@sample_input_diff)
      assert_equal solution.part_two, 'fgij'
    end

    def test_solution_part_two_with_input
      solution = Solution.new(@test_input)
      assert_equal solution.part_two, "hhvsdkatysmiqjxunezgwcdpr"
    end

    private

    def read_input
      File.read("input")
    end
  end
end