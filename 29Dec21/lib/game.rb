require_relative 'humanplayer'

class Game
    def initialize(player_1, player_2)
        @players = [HumanPlayer.new(player_1, :black), HumanPlayer.new(player_2, :white)]
        @board = Board.new
        @current_player_idx = 0
    end

    def change_player
        next_player_idx = @current_player_idx == 0 ? 1 : 0

        @current_player_idx = next_player_idx
    end
end