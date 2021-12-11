require_relative 'tic-tac-toe-node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    tic_tac_toe_node = TicTacToeNode.new(game.board, mark)
    children = tic_tac_toe_node.children
    winning_nodes = self.get_winning_nodes(children, mark)

    return get_tie_game_move(children, mark) if winning_nodes.empty?

    winning_nodes.sample.prev_move_pos

  end

  def get_winning_nodes(children, mark)
    winning_nodes = []

    children.each do |child|
      winning_nodes << child if child.winning_node?(mark)
    end

    winning_nodes
  end

  def get_tie_game_move(children, mark)
    children.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end

    raise "Could not find any non-losing moves, which shouldn't be possible."
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
