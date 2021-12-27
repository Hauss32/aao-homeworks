require_relative 'slideable'
require_relative 'piece'

class Bishop < Piece
    include Slideable

    def initialize(color, board, position)
        super
    end

    def symbol
        :Bishop
    end

    def move_dirs
        self.diagonal_dirs
    end
end