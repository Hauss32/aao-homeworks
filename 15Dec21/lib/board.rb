require_relative 'piece'

class Board
    def initialize
        @rows = Array.new(8) { Array.new(8, nil) }
        @null_piece = nil

        [0,1,6,7].each do |row|
            (0..7).each do |cell| 
                @rows[row][cell] = Piece.new(:black, self, [row, cell])
            end
        end
    end

    def [](pos)
        y, x = pos
        @rows[y][x]
    end

    def []=(pos, val)
        y, x = pos
        @rows[y][x] = val
    end

    def move_piece(color, start_pos, end_pos)
        piece = self[start_pos]
        raise ArgumentError.new("Selected starting cell is empty.") if piece.nil?
        raise ArgumentError.new("Ending position is not valid.") unless piece.valid_pos?(end_pos)

        piece.position = end_pos
        piece.color = color
        self[start_pos] = nil
        self[end_pos] = piece
    end
end