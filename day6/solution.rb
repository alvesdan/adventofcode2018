module Day6
  class Solution
    attr_reader :coordinates, :xy_lookup
    def initialize(input)
      @coordinates = parse_input(input)
    end
    
    def manhattan_distance(a, b)
      (a[0]-b[0]).abs + (a[1]-b[1]).abs
    end
    
    def get_coordinates_location_distances
      max = @coordinates.flatten.max
      close_locations = Hash.new { |hash, key| hash[key] = 0 }
      infinites = Hash.new { |hash, key| hash[key] = 0 }

      (0..max).each do |x|
        (0..max).each do |y|
          all_distances = Hash.new { |hash, key| hash[key] = [] }

          @coordinates.each do |coord|
            coord_distance = manhattan_distance([x, y], coord)
            all_distances[coord_distance] << coord
          end

          _distance, coords = all_distances.sort_by { |distance, _| distance }.first
          closest_coord = coords.first

          # Setting infinity coordinate
          if x == 0 || x == max || y == 0 || y == max
            infinites[closest_coord] = true
          end

          # If more than one coordinate has same distance, skip it
          if coords.size > 1
            next
          else
            close_locations[closest_coord] += 1
          end
        end
      end
      
      [close_locations, infinites]
    end
    
    def closest_locations_for(coord)
      close_locations, _ = get_coordinates_location_distances
      close_locations[coord]
    end
    
    def part_one
      close_locations, infinites = get_coordinates_location_distances
      close_locations.select  { |c, d| !infinites.has_key?(c) }
                     .sort_by { |c, d| d }
                     .last
                     .last
    end
    
    def part_two
      max = @coordinates.flatten.max
      limit = 10000
      count = 0

      (0..max).each do |x|
        (0..max).each do |y|
          total_distance = @coordinates.reduce(0) do |total, coord|
            total + manhattan_distance([x, y], coord)
          end
          count += 1 if total_distance < limit
        end
      end
      
      count
    end
    
    protected
    
    def parse_input(input)
      input.split("\n").map do |line|
        line.split(",").map { |n| n.strip.to_i }
      end
    end
  end
end
