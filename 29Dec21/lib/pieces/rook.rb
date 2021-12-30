require_relative 'slideable'
require_relative 'piece'

class Rook < Piece
    include Slideable

    def initialize(color, board, position)
        super
    end

    def symbol
        :Rook
    end

    def unicode_symbol
        @color == :black ? " ♜ " : " ♖ "
    end

    def move_dirs
        self.horizontal_dirs
    end
end