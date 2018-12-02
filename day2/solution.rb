<<-QUESTION
Late at night, you sneak to the warehouse - who knows what kinds of paradoxes
you could cause if you were discovered - and use your fancy wrist device to
quickly scan every box and produce a list of the likely candidates (your
puzzle input).

To make sure you didn't miss any, you scan the likely candidate boxes again,
counting the number that have an ID containing exactly two of any letter and
then separately counting those with exactly three of any letter. You can
multiply those two counts together to get a rudimentary checksum and compare
it to what your device predicts.

For example, if you see the following box IDs:

abcdef contains no letters that appear exactly two or three times.
bababc contains two a and three b, so it counts for both.
abbcde contains two b, but no letter appears exactly three times.
abcccd contains three c, but no letter appears exactly two times.
aabcdd contains two a and two d, but it only counts once.
abcdee contains two e.
ababab contains three a and three b, but it only counts once.

Of these box IDs, four of them contain a letter which appears exactly twice,
and three of them contain a letter which appears exactly three times.
Multiplying these together produces a checksum of 4 * 3 = 12.

What is the checksum for your list of box IDs?

--- Part Two ---
Confident that your list of box IDs is complete, you're ready to find the
boxes full of prototype fabric.

The boxes will have IDs which differ by exactly one character at the same
position in both strings. For example, given the following box IDs:

abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz
The IDs abcde and axcye are close, but they differ by two characters (the
second and fourth). However, the IDs fghij and fguij differ by exactly one
character, the third (h and u). Those must be the correct boxes.

What letters are common between the two correct box IDs? (In the example
above, this is found by removing the differing character from either ID,
producing fgij.)
QUESTION

module Day2
  class Solution
    def self.run(input)
      counters = { 2 => 0, 3 => 0 }

      input.each do |box|
        letters = box.split(//)
        letters_hsh = generate_letters_count(letters)

        counted_three = false
        counted_two   = false

        letters_hsh.each do |_, count|
          if count == 3 and !counted_three
            counters[3] += 1
            counted_three = true
          end

          if count == 2 and !counted_two
            counters[2] += 1
            counted_two = true
          end
        end
      end

      counters.values.reduce(:*)
    end

    def self.generate_letters_count(letters)
      letters.reduce({}) do |hsh, l|
        hsh[l]||= 0
        hsh[l]+= 1
        hsh
      end
    end
  end

  class SolutionPartTwo
    def self.run(input)
      pairs = {}
      input_as_array = input.map { |b| b.split(//) }
      current_diff = Float::INFINITY
      result = nil

      while box = input_as_array.shift
        input_as_array.each do |b|
          next if box == b
          matched, diff = diff_with_order(box, b)

          if diff < current_diff
            current_diff = diff
            result = matched.join
          end
        end
      end

      result
    end

    def self.diff_with_order(a, b)
      matched = []
      diff = 0
      a.each_with_index do |v, i|
        if v == b[i]; matched << v else diff += 1 end
      end
      [matched, diff]
    end
  end
end