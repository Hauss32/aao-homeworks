class Piece
    attr_accessor :color, :position

    def initialize(color, board, position)
        @color, @board, @position = color, board, position
    end

    def inspect
        { color:@color, position:@position}
    end

    def to_s
       @position.join(",")
    end

    def empty?
        @position.empty?
    end

    def valid_pos?(pos)
        y, x = pos
        idxs = (0..7).to_a
        not_own_pos = pos != @position

        idxs.include?(y) && idxs.include?(x) && not_own_pos
    end

    def valid_moves
        nil
    end

    def symbol
        nil
    end

    private
    def move_into_check?(end_pos)
        nil
    end


end