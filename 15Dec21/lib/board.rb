require_relative 'piece'

class Board
    def initialize
        @rows = Array.new(8) { Array.new(8, nil) }
        @null_piece = nil

        [0,1,6,7].each do |row|
            (0..7).each do |cell| 
                @rows[row][cell] = Piece.new(:black, self, [row, cell])
            end
        end
    end
end

b = Board.new
p b