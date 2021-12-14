class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1, @player2 = name1, name2
    @cups = []

    self.place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    (0...14).each do |cup|
      if cup == 6 || cup == 13
        @cups << []
      else
        @cups << [:stone, :stone, :stone, :stone]
      end
    end
  end

  def valid_move?(start_pos)
    not_store = start_pos != 6 && start_pos != 13
    raise 'Invalid starting cup' unless start_pos.between?(0, 13) && not_store
    raise 'Starting cup is empty' if @cups[start_pos].empty?

    true
  end

  def make_move(start_pos, current_player_name)
    skip_store = current_player_name == @player1 ? 13 : 6
    cup = @cups[start_pos]
    next_idx = start_pos
    stones = cup.slice!(0...cup.length)

    while stones.length > 0
      next_idx = (next_idx + 1) % 14
      next if next_idx == skip_store

      stone = stones.pop
      @cups[next_idx] << stone
    end

    self.render

    self.next_turn(next_idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13
      return :prompt
    elsif @cups[ending_cup_idx].length == 1
      return :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end

b = Board.new("P1", "P2")
p b
