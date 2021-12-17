class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
      self.take_turn
    end

    puts self.game_over_message
    self.reset_game
  end

  def take_turn
    self.show_sequence
    self.require_sequence
    unless @game_over
      puts self.round_success_message
      @sequence_length += 1
    end

  end

  def show_sequence
    self.add_random_color
    p @seq.last
  end

  def require_sequence
    correct_guesses = 0

    until correct_guesses == @sequence_length || @game_over
      puts "Enter the next color in the sequence (red/blue/green/yellow)"
      input = gets.chomp
      if input == @seq[correct_guesses]
        correct_guesses += 1
      else
        @game_over = true
      end
    end

    nil
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    "Success!"
  end

  def game_over_message
    "Game over."
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
