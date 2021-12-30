require_relative 'stepable'
require_relative 'piece'

class King < Piece
    include Stepable

    def initialize(color, board, position)
        super
    end

    def symbol
        :King
    end

    def unicode_symbol
        @color == :black ? " ♚ " : " ♔ "
    end

    def move_diffs
        move_diffs = [
            [0, -1],
            [0, 1],
            [1, 1],
            [1, 0],
            [1, -1],
            [-1, 1],
            [-1, 0],
            [-1, -1]
        ]

        move_diffs
    end
end