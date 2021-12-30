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
        @curr_player = @players[0]
    end

    def play
        puts "\nWelcome to Chess! Let's begin..."
        sleep(1)
        puts "Preparing game..."
        sleep(2)

        until @board.checkmate?(@curr_player.color)
            valid_play = prompt_player
            until valid_play
                puts "Try again, #{@curr_player.name}"
                sleep(1)
                valid_play = prompt_player
            end
            @display.render
            change_player
        end

        puts "————————————————"
        puts "—— CHECKMATE! ——"
        puts "————————————————"

        change_player

        puts "\n#{@curr_player.name} is the winner."
    end

    def change_player
        curr_player_idx = @players.index(@curr_player)
        next_player_idx = curr_player_idx == 0 ? 1 : 0

        @curr_player = @players[next_player_idx]
    end

    def prompt_player
        @curr_player.make_move
    end
end