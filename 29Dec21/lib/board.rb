require_relative 'pieces/bishop'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/knight'
require_relative 'pieces/king'
require_relative 'pieces/pawn'
require_relative 'pieces/nullpiece'
require_relative 'display'

class Board
    KING = { black:[[0,3]], white:[[7,3]] }
    QUEEN = { black:[[0,4]], white:[[7,4]] }
    BISHOP = { black:[[0,2], [0,5]], white:[[7,2], [7,5]] }
    KNIGHT = { black:[[0,1], [0,6]], white:[[7,1], [7,6]] }
    ROOK = { black:[[0,0], [0,7]], white:[[7,0], [7,7]] }
    PAWN = { black:[[1,0], [1,1], [1,2], [1,3], [1,4], [1,5], [1,6], [1,7]], 
        white:[[6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7]] }

    attr_reader :rows, :display

    def initialize(rows=nil)
        @null_piece = NullPiece.instance
        @rows = Array.new(8) { Array.new(8, @null_piece) }
        @display = Display.new(self)

        self.set_board if rows.nil?
    end

    def [](pos)
        y, x = pos
        @rows[y][x]
    end

    def []=(pos, val)
        y, x = pos
        @rows[y][x] = val
    end

    def dup
        new_rows = []
        new_board = Board.new(new_rows)

        @rows.each do |row|
            new_row = []

            row.each do |piece|
                if piece == @null_piece
                    new_row << @null_piece
                    next
                end
                
                color = piece.color
                type = piece.class
                pos = piece.position.dup
                new_piece = type.new(color, new_board, pos)

                new_row << new_piece
            end

            new_rows << new_row
        end

        new_board.overwrite_rows(new_rows)

        new_board
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

    def render
        @display.render
    end

    def move_piece(start_pos, end_pos)
        piece = self[start_pos]
        raise ArgumentError.new("Selected starting cell is empty.") if self[start_pos] == @null_piece
        raise ArgumentError.new("Ending position is not on the board.") unless self.valid_pos?(end_pos)
        raise ArgumentError.new("Move is invalid for that piece.") unless piece.moves.include?(end_pos)

        piece.position = end_pos
        self[start_pos] = @null_piece
        self[end_pos] = piece
    end

    def valid_pos?(pos)
        y, x = pos
        idxs = (0..7).to_a

        idxs.include?(y) && idxs.include?(x)
    end

    def checkmate?(color)
        return false unless self.in_check?(color)

        self.has_valid_moves?(color) ? false : true
    end

    def in_check?(color)
        opp_color = color == :black ? :white : :black
        king_pos = self.find_king(color)

        @rows.each do |row|
            row.each do |piece|
                next unless piece.color == opp_color
                return true if piece.moves.include?(king_pos)
            end
        end

        false
    end

    def find_king(color)
        @rows.each do |row|
            row.each do |piece|
                return piece.position if piece.is_a?(King) && piece.color == color
            end
        end

        nil
    end

    def has_valid_moves?(color)
        @rows.each do |row|
            row.each do |piece|
                next unless piece.color == color

                return true if piece.valid_moves
            end
        end

        false
    end

    def overwrite_rows(new_rows)
        @rows = new_rows
    end
end