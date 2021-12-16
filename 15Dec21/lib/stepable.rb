module Stepable
    def moves
        y, x = @position
        diffs = move_diffs
        moves = []

        diffs.each do |move|
            dy = y + move[0]
            dx = x + move[1]
            new_pos = [dy, dx]
            
            next unless @board.valid_pos?(new_pos)

            piece = @board[new_pos]
            moves << new_pos if piece.nil? || piece.color != @color
        end

        moves
    end

    private
    def move_diffs
        nil
    end
end