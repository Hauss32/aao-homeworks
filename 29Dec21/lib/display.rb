require_relative 'cursor'
require 'colorize'

class Display
    attr_reader :cursor, :board

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], @board)
    end

    def move
        render
        while true
            @cursor.get_input
            render
        end
    end

    def render
        system("clear")
        puts "\n"
        puts "————————————————————————————————————————————————————————————"
        @board.rows.each_with_index do |row, y|
            row_strs = []
            row.each_with_index do |piece, x|
                piece_str = piece.symbol.to_s.ljust(7)
                if @cursor.selected == [y, x]
                    piece_str = piece_str.colorize(:color => :black, :background => :light_red)
                elsif @cursor.cursor_pos == [y, x]
                    piece_str = piece_str.colorize(:color => :black, :background => :light_green)
                end

                row_strs << piece_str
            end


            puts row_strs.join(" ")
        end

        puts "————————————————————————————————————————————————————————————"
    end
end