require_relative 'humanplayer'

class Game
    def initialize(player_1, player_2)
        @players = [HumanPlayer.new(player_1, :black), HumanPlayer.new(player_2, :white)]
        @board = Board.new
        @current_player_idx = 0
    end
end