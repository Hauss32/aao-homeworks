require_relative 'pieces/bishop'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/knight'
require_relative 'pieces/king'
require_relative 'pieces/pawn'
require_relative 'pieces/nullpiece'
require 'colorize'

class Board
    KING = { white:[[0,3]], black:[[7,3]] }
    QUEEN = { white:[[0,4]], black:[[7,4]] }
    BISHOP = { white:[[0,2], [0,5]], black:[[7,2], [7,5]] }
    KNIGHT = { white:[[0,1], [0,6]], black:[[7,1], [7,6]] }
    ROOK = { white:[[0,0], [0,7]], black:[[7,0], [7,7]] }
    PAWN = { white:[[1,0], [1,1], [1,2], [1,3], [1,4], [1,5], [1,6], [1,7]], 
        black:[[6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7]] }

    def initialize
        @null_piece = NullPiece.instance
        @rows = Array.new(8) { Array.new(8, @null_piece) }

        self.set_board
    end

    def [](pos)
        y, x = pos
        @rows[y][x]
    end

    def []=(pos, val)
        y, x = pos
        @rows[y][x] = val
    end

    def set_board
        pieces = { 
            'King'=> Board::KING,
            'Queen'=> Board::QUEEN,
            'Bishop'=> Board::BISHOP,
            'Knight'=> Board::KNIGHT,
            'Rook'=> Board::ROOK,
            'Pawn'=> Board::PAWN
        }

        pieces.each do |piece, colors|
            class_type = Object.const_get(piece)

            colors.each do |color, pos_arr|
                pos_arr.each { |pos| self[pos] = class_type.new(color, self, pos) }
            end
        end
    end

    def move_piece(start_pos, end_pos)
        piece = self[start_pos]
        raise ArgumentError.new("Selected starting cell is empty.") if self[start_pos] == @null_piece
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