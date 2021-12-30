require_relative 'humanplayer'
require_relative 'board'
require_relative 'display'

class Game
    def initialize(player_1, player_2)
        @board = Board.new
        @display = Display.new(@board)
        @players = [
            HumanPlayer.new(player_1, :black, @display), 
            HumanPlayer.new(player_2, :white, @display)
        ]
        @current_player_idx = 0
    end

    def change_player
        next_player_idx = @current_player_idx == 0 ? 1 : 0

        @current_player_idx = next_player_idx
    end
end