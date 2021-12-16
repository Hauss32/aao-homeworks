module Slideable
    HORIZONTAL_DIRS = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    DIAGONAL_DIRS = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

    def horizontal_dirs
        HORIZONTAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        dirs = move_dirs
        moves = []

        dirs.each do |move|
            moves += grow_unblocked_moves_in_dir(*move)
        end

        moves
    end

    private
    def move_dirs
        nil
    end

    def grow_unblocked_moves_in_dir(dy, dx)
        y, x = @position
        moves = []

        while true
            y += dy
            x += dx
            break unless @board.valid_pos?(pos)

            if @board[pos].nil?
                moves << [y, x]
            else
                moves << [y, x] if @board[pos].color != @color
                break
            end
        end
        
        moves
    end
    
end