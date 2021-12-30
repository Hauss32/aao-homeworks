require_relative 'slideable'
require_relative 'piece'

class Queen < Piece
    include Slideable

    def initialize(color, board, position)
        super
    end

    def symbol
        :Queen
    end

    def unicode_symbol
        @color == :black ? " ♛ " : " ♕ "
    end

    def move_dirs
        move_dirs = self.diagonal_dirs
        move_dirs += self.horizontal_dirs

        move_dirs
    end
end