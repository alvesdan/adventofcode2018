<<-QUESTION
--- Day 4: Repose Record ---
You've sneaked into another supply closet - this time, it's across from the
prototype suit manufacturing lab. You need to sneak inside and fix the issues
with the suit, but there's a guard stationed outside the lab, so this is as
close as you can safely get.

As you search the closet for anything that might help, you discover that you're
not the first person to want to sneak in. Covering the walls, someone has spent
an hour starting every midnight for the past few months secretly observing this
guard post! They've been writing down the ID of the one guard on duty that night
- the Elves seem to have decided that one guard was enough for the overnight
shift - as well as when they fall asleep or wake up while at their post (your
puzzle input).

For example, consider the following records, which have already been organized
into chronological order:

[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:05] falls asleep
[1518-11-01 00:25] wakes up
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

Timestamps are written using year-month-day hour:minute format. The guard
falling asleep or waking up is always the one whose shift most recently started.
Because all asleep/awake times are during the midnight hour (00:00 - 00:59),
only the minute portion (00 - 59) is relevant for those events.

Visually, these records show that the guards are asleep at these times:

Date   ID   Minute
            000000000011111111112222222222333333333344444444445555555555
            012345678901234567890123456789012345678901234567890123456789
11-01  #10  .....####################.....#########################.....
11-02  #99  ........................................##########..........
11-03  #10  ........................#####...............................
11-04  #99  ....................................##########..............
11-05  #99  .............................................##########.....

The columns are Date, which shows the month-day portion of the relevant day; ID,
which shows the guard on duty that day; and Minute, which shows the minutes
during which the guard was asleep within the midnight hour. (The Minute column's
header shows the minute's ten's digit in the first row and the one's digit in
the second row.) Awake is shown as ., and asleep is shown as #.

Note that guards count as asleep on the minute they fall asleep, and they count
as awake on the minute they wake up. For example, because Guard #10 wakes up at
00:25 on 1518-11-01, minute 25 is marked as awake.

If you can figure out the guard most likely to be asleep at a specific time, you
might be able to trick that guard into working tonight so you can have the best
chance of sneaking in. You have two strategies for choosing the best
guard/minute combination.

Strategy 1: Find the guard that has the most minutes asleep. What minute does
that guard spend asleep the most?

In the example above, Guard #10 spent the most minutes asleep, a total of 50
minutes (20+25+5), while Guard #99 only slept for a total of 30 minutes
(10+10+10). Guard #10 was asleep most during minute 24 (on two days, whereas any
other minute the guard was asleep was only seen on one day).

While this example listed the entries in chronological order, your entries are
in the order you found them. You'll need to organize them before they can be
analyzed.

What is the ID of the guard you chose multiplied by the minute you chose? (In
the above example, the answer would be 10 * 24 = 240.)

--- Part Two ---
Strategy 2: Of all guards, which guard is most frequently asleep on the same minute?

In the example above, Guard #99 spent minute 45 asleep more than any other guard or
minute - three times in total. (In all other cases, any guard spent any minute
asleep at most twice.)

What is the ID of the guard you chose multiplied by the minute you chose? (In the
above example, the answer would be 99 * 45 = 4455.)
QUESTION

module Day4
  class Solution

    attr_reader :input, :guards

    def initialize(input)
      @input = sort_input(input)
      @guards = parse_guards(
        Hash.new { |hash, key|
          hash[key] = {
            sleep_minutes: 0,
            sleep_ranges: []
          }
        }
      )
    end

    def sleepy_guard
      @guards.sort_by { |id, data| data[:sleep_minutes] }.last.first
    end

    def most_frequent_minute_for_guard(guard_id, return_sum: false)
      return nil unless @guards.has_key?(guard_id)

      minutes = Hash.new { |hash, key| hash[key] = 0 }
      guard = @guards[guard_id]

      guard[:sleep_ranges].each do |range|
        range.each do |minute|
          minutes[minute] += 1
        end
      end

      id, sum = minutes.sort_by { |_k, v| v }.last
      return_sum ? sum : id
    end

    def solution_part_one
      guard = sleepy_guard
      most_frequent_minute_for_guard(guard) * guard
    end

    def solution_part_two
      current_guard = nil
      minute_frequency = nil

      @guards.each do |id, guard|
        minute = most_frequent_minute_for_guard(id, return_sum: true)
        next unless minute
        unless minute_frequency
          current_guard = id
          minute_frequency = minute
          next
        end

        # If the current minute has a higher frequency we update
        next unless minute_frequency < minute
        minute_frequency = minute
        current_guard = id
      end

      current_guard * most_frequent_minute_for_guard(current_guard)
    end

    protected

    LINE_REGEX = /([0-9]+)-([0-9]+)-([0-9]+) ([0-9]+):([0-9]+)\][\D]+([0-9]+)?/

    def sort_input(input)
      input.split("\n").sort
    end

    def parse_line(line)
      year, month, day, hour, minute, guard = line.match(LINE_REGEX).captures
      if guard
        [minute.to_i, :begins, guard.to_i]
      else
        [minute.to_i, parse_instruction(line)]
      end
    end

    def parse_instruction(instruction)
      case instruction
      when /asleep/
        :sleeps
      when /wakes/
        :wakes_up
      end
    end

    def parse_guards(guards_hsh)
      current_guard = nil
      sleep_minute  = nil

      @input.each do |line|
        minute, instruction, guard = parse_line(line)
        current_guard = guard if guard
        sleep_minute = minute if instruction == :sleeps

        if instruction == :wakes_up
          range = (sleep_minute...minute)
          guards_hsh[current_guard][:sleep_minutes] += range.size
          guards_hsh[current_guard][:sleep_ranges] << range
        end
      end

      guards_hsh
    end
  end
end
