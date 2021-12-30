class Piece
    attr_accessor :color, :position

    def initialize(color, board, position)
        @color, @board, @position = color, board, position
    end

    def inspect
        { color:@color, type:self.class, position:@position}
    end

    def to_s
       @position.join(",")
    end

    def empty?
        @position.empty?
    end

    def valid_moves
        valid_moves = []

        self.moves.each do |move|
            moves_into_check = move_into_check?(move)

            valid_moves << move unless moves_into_check
        end

        valid_moves
    end

    def symbol
        nil
    end

    def unicode_symbol
        "   "
    end

    def moves
        []
    end

    private
    def move_into_check?(end_pos)
        dup_board = @board.dup

        dup_board.move_piece!(@position, end_pos)

        if dup_board.in_check?(@color)
            return true
        end

        false
    end


end