module Day5
  class Solution
    def initialize(input)
      @input = input
    end

    def opposite_polarity?(a, b)
      return false if a === b
      a.downcase === b.downcase
    end

    def remove_reacting_units(units)
      input_as_array = units.split(//)
      index = 0

      while index < input_as_array.size - 2
        a = input_as_array[index]
        b = input_as_array[index + 1]

        if opposite_polarity?(a, b)
          input_as_array.delete_at(index)
          input_as_array.delete_at(index)
          index -= 1
          next
        end

        index += 1
      end

      input_as_array.join
    end

    def part_one
      remove_reacting_units(@input).size
    end

    def remove_units_of_same_type(units, type)
      units.split(//).reject { |u|
        u.downcase === type
      }.join
    end

    def available_units(units)
      units_hsh = {}
      units.split(//).each do |u|
        units_hsh[u.downcase] = 1
      end
      units_hsh.keys
    end

    def part_two
      shortest_polymer = Float::INFINITY
      available_units(@input).each do |type|
        cleaned_units = remove_units_of_same_type(@input, type)
        polymer_size = remove_reacting_units(cleaned_units).size

        if polymer_size < shortest_polymer
          shortest_polymer = polymer_size
        end
      end

      shortest_polymer
    end
  end
end