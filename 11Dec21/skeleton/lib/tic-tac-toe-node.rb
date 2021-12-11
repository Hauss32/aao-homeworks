require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
    attr_reader :board, :next_mover_mark, :prev_move_pos

    def initialize(board, next_mark, prev_pos=nil)
        @board = board
        @next_mover_mark = next_mark
        @prev_move_pos = prev_pos
    end

    def losing_node?(mark)
        if @board.over?
            return @board.winner && @board.winner != mark
        end

        if @next_mover_mark != mark
            self.children.any? { |child| child.losing_node?(mark) }
        else
            self.children.all? { |child| child.losing_node?(mark) }
        end
    end

    def winning_node?(mark)
        if @board.over?
            return @board.winner == mark
        end

        if @next_mover_mark != mark
            self.children.all? { |child| child.winning_node?(mark) }
        else
            self.children.any? { |child| child.winning_node?(mark) }
        end
    end

    def children
        empties = []
        children = []

        @board.rows.each_with_index do |row, y|
            row.each_with_index { |cell, x| empties << [y, x] if cell.nil? }
        end

        empties.each do |cell|
            board = @board.dup
            board[cell] = @next_mover_mark
            next_mark = @next_mover_mark == :x ? :o : :x
            node = TicTacToeNode.new(board, next_mark, cell)

            children << node
        end
        children
    end
end
