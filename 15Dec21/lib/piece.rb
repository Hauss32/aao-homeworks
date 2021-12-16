class Piece
    attr_accessor :color, :position

    def initialize(color, board, position)
        @color, @board, @position = color, board, position
    end

    def inspect
        { color:@color, position:@position}
    end

    def valid_pos?(pos)
        y, x = pos
        idxs = (0..7).to_a
        not_own_pos = pos != @position

        idxs.include?(y) && idxs.include?(x) && not_own_pos
    end
end