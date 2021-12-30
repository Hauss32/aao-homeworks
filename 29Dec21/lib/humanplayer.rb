class HumanPlayer
    def initialize(name, color, display)
        @name = name
        @color = color
        @display = display
    end

    def make_move
        cursor = @display.cursor
        board = @display.board

        selected_pos = nil

        until selected_pos && board[selected_pos].color == @color
            @display.render
            puts "\nSelect a #{@color} piece."

            selected_pos = cursor.get_input 
        end

        move_to = nil

        until move_to && board[move_to].class == NullPiece
            @display.render
            puts "\nSelect an empty cell to move to."

            move_to = cursor.get_input 
        end

        begin
            board.move_piece(selected_pos, move_to)
        rescue => exception
            puts exception
            return false
        end

        true
    end
end