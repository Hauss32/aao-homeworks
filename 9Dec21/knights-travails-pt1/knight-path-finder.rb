class KnightClassFinder
    def initialize(pos)
        @root_node = nil
        @board = []

        self.add_board_positions
    end

    def add_board_positions
        board_size = 8

        (0...board_size).each do |y|
            (0...board_size).each { |x| @board << [y, x] }
        end
    end
end

p kcf = KnightClassFinder.new([1,1])