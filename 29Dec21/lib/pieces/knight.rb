require_relative 'stepable'
require_relative 'piece'

class Knight < Piece
    include Stepable

    def initialize(color, board, position)
        super
    end

    def symbol
        :Knight
    end

    def unicode_symbol
        @color == :black ? " ♞ " : " ♘ "
    end

    def move_diffs
        move_diffs = [
            [-2, -1],
            [-2, 1],
            [-1, -2],
            [-1, 2],
            [1, -2],
            [1, 2],
            [2, -1],
            [2, 1]
        ]

        move_diffs
    end
end