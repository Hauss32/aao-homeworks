require_relative 'piece'

class Pawn < Piece

    def initialize(color, board, position)
        super
    end

    def symbol
        :Pawn
    end

    def unicode_symbol
        @color == :black ? " ♟︎ " : " ♙ "
    end

    def moves
        steps = forward_steps
        attacks = side_attacks

        steps += attacks
    end

    private

    def at_start_row?
        start_row = @color == :white ? 6 : 1

        @position[0] == start_row
    end

    def forward_dir
        @color == :black ? 1 : -1
    end

    def forward_steps
        steps_allowed = at_start_row? ? [1, 2] : [1]
        dir = forward_dir
        steps_allowed.map! { |step| step * dir }
        
        moves = steps_allowed.each_with_object([]) do |step, moves|
            y, x = @position
            y += step
            moves << [y, x]
        end

        moves.select { |move| @board.valid_pos?(move) && @board[move].is_a?(NullPiece) }
    end

    def side_attacks
        opp_color = @color == :white ? :black : :white
        y, x = @position
        y += forward_dir
        diags = [[y, x+1], [y, x-1]]

        diags.select { |diag| @board.valid_pos?(diag) && @board[diag].color == opp_color}
    end
end