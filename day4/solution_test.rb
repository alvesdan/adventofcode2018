require "minitest/autorun"
require_relative "./solution.rb"

module Day4
  class SolutionTest < Minitest::Test
    def setup
      @test_input = read_input
      @sample_input = <<-SAMPLE_INPUT
[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:25] wakes up
[1518-11-01 00:05] falls asleep
[1518-11-01 00:30] falls asleep
[1518-11-01 00:55] wakes up
[1518-11-01 23:58] Guard #99 begins shift
[1518-11-02 00:40] falls asleep
[1518-11-02 00:50] wakes up
[1518-11-03 00:05] Guard #10 begins shift
[1518-11-03 00:24] falls asleep
[1518-11-03 00:29] wakes up
[1518-11-04 00:02] Guard #99 begins shift
[1518-11-04 00:36] falls asleep
[1518-11-04 00:46] wakes up
[1518-11-05 00:03] Guard #99 begins shift
[1518-11-05 00:45] falls asleep
[1518-11-05 00:55] wakes up
      SAMPLE_INPUT
    end

    def test_it_can_sort_input
      solution = Solution.new(@sample_input)
      assert_equal solution.input[1], "[1518-11-01 00:05] falls asleep"
    end

    def test_it_builds_a_data_structure_with_guards_shifts
      solution = Solution.new(@sample_input)
      assert_equal solution.guards, {
        10 => {
          sleep_minutes: 50,
          sleep_ranges: [5...25, 30...55, 24...29]
        },
        99 => {
          sleep_minutes: 30,
          sleep_ranges: [40...50, 36...46, 45...55]
        }
      }
    end

    def test_it_can_find_the_sleepy_guard
      solution = Solution.new(@sample_input)
      assert_equal solution.sleepy_guard, 10
    end

    def test_it_can_find_the_most_frequent_minute
      solution = Solution.new(@sample_input)
      assert_equal solution.most_frequent_minute_for_guard(10), 24
    end

    def test_it_can_find_solution_for_sample_input
      solution = Solution.new(@sample_input)
      assert_equal solution.solution_part_one, 240
    end

    def test_it_can_find_solution_for_input
      solution = Solution.new(@test_input)
      assert_equal solution.solution_part_one, 142515
    end

    def test_it_can_find_solution_part_two_for_sample_input
      solution = Solution.new(@sample_input)
      assert_equal solution.solution_part_two, 4455
    end

    def test_it_can_find_solution_part_two_for_input
      solution = Solution.new(@test_input)
      assert_equal solution.solution_part_two, 5370
    end

    private

    def read_input
      File.read("#{__dir__}/input")
    end
  end
end
