require_relative 'pieces/bishop'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/knight'
require_relative 'pieces/king'
require_relative 'pieces/pawn'



class Board
    def initialize
        @rows = Array.new(8) { Array.new(8, nil) }
        @null_piece = nil

        [0,1,6,7].each do |row|
            (0..7).each do |cell|
                color = row <= 2 ? :black : :white
                @rows[row][cell] = Piece.new(color, self, [row, cell])
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

    def move_piece(start_pos, end_pos)
        piece = self[start_pos]
        raise ArgumentError.new("Selected starting cell is empty.") if self[start_pos].nil?
        raise ArgumentError.new("Ending position is not on the board.") unless self.valid_pos?(end_pos)
        raise ArgumentError.new("Move is invalid for that piece.") unless piece.moves.include?(end_pos)

        piece.position = end_pos
        self[start_pos] = nil
        self[end_pos] = piece
    end

    def valid_pos?(pos)
        y, x = pos
        idxs = (0..7).to_a

        idxs.include?(y) && idxs.include?(x)
    end
end