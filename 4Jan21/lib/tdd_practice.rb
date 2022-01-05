class Array
    def my_uniq
        uniq_arr = []

        self.each do |el|
            uniq_arr << el unless uniq_arr.include?(el)
        end

        uniq_arr
    end

    def two_sum
        unless self.all? { |el| el.is_a?(Integer)}
            raise ArgumentError.new("All array elements must be integers.") 
        end

        sum_to_zero_positions = []

        (0...self.length - 1).each do |idx|
            (idx + 1...self.length).each do |other_idx|
                if self[idx] + self[other_idx] == 0
                    sum_to_zero_positions << [idx, other_idx]
                end
            end
        end

        sum_to_zero_positions
    end

    def my_transpose
        first_len = self[0].length unless self[0].empty?
        self.each do |el|
            unless el.is_a?(Array) && el.length == first_len
                raise ArgumentError.new("All elements must be Arrays of the same length.")
            end
        end

        new_matrix = Array.new(self.length) { Array.new }

        self.each do |row|
            row.each_with_index { |el, idx| new_matrix[idx] << el }
        end

        new_matrix
    end
end

def stock_picker(prices)
    is_array = prices.is_a?(Array)
    is_all_nums = prices.all? { |el| el.is_a?(Numeric) }
    is_length = prices.length > 1

    unless is_array && is_all_nums && is_length
        raise ArgumentError.new("Argument must be array of at least 2 numbers.")
    end

    best_days = [0, 1]

    (0...prices.length - 1).each do |idx|
        (idx...prices.length).each do |other_idx|
            curr_min, curr_max = best_days
            curr_delta = prices[curr_max] - prices[curr_min]
            this_delta = prices[other_idx] - prices[idx]

            best_days = [idx, other_idx] if this_delta > curr_delta
        end
    end

    best_days
end

class Tower
    attr_reader :towers

    def initialize
        @towers = [[4, 3, 2, 1], [], []]
    end

    def play
        until won?
            p @towers
            move = get_input
            begin
                move(move)
            rescue => exception
                puts exception
                puts "Please try again."
            end
        end

        puts "You solved it!!!"
    end

    def move(pos)
        from_tower = @towers[pos[0]]
        to_tower = @towers[pos[1]]

        unless valid_towers?(pos)
            raise ArgumentError.new("One or both tower idxs provided are not valid.")
        end

        unless valid_move?(pos)
            raise ArgumentError.new("Move is not valid")
        end

        piece = from_tower.pop
        to_tower.push(piece)

        true
    end

    def won?
        @towers[-1] == [4, 3, 2, 1] ? true : false
    end

    private
    def valid_towers?(pos)
        valid_towers = [0, 1, 2]
        valid_towers.include?(pos[0]) && valid_towers.include?(pos[1]) ? true : false
    end

    def valid_move?(pos)
        from_tower = @towers[pos[0]]
        to_tower = @towers[pos[1]]

        tower_has_piece = from_tower.length > 0
        return false unless tower_has_piece

        is_smaller_or_empty = to_tower.empty? || from_tower[-1] < to_tower[-1]

        is_smaller_or_empty ? true : false
    end

    def get_input
        puts "Enter a move in the format From_Tower,To_Tower (e.g. 0,1)"
        input = gets.chomp
        move = input.split(",")
        move.map! { |el| Integer(el) }
        
        unless move.length == 2
            puts "\nThat input was invalid. Please try again."
            get_input
        end
        
        move
    rescue
        puts "\nThat input was invalid. Please try again."
        get_input
    end
end