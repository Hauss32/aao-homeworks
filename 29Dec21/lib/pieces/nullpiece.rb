require 'singleton'
require_relative 'piece'

class NullPiece < Piece
    include Singleton

    def initialize
       @color = nil
       @position = nil
    end

    def symbol
        :nil
    end
end