require_relative 'hand.rb'

class Player
    attr_reader :hand, :bank, :name, :current_bet

    def initialize(name, amount)
        @name = name
        @bank = amount
        @hand = nil
        @current_bet = 0
    end

    def new_hand
        @hand = Hand.new
    end

    def receive_cards(cards_arr)
        cards_arr.each { |card| @hand.add_card(card) }

        true
    end

    def discard_cards(card_names)
        cards = get_cards(card_names)

        cards.each { |card| @hand.discard(card) }

        true
    end

    def execute_bet(amount)
        if @bank - amount < 0
            raise ArgumentError.new("Insufficient bank to support that bet.")
        end

        @bank -= amount

        amount
    end

    def update_current_bet(amount)
        @current_bet = amount
    end

    def receive_winnings(amount)
        @bank += amount

        true
    end

    def fold
        @hand = nil
        @current_bet = 0
    end

    def get_action_input
        puts "#{@name}, enter your move (type: Fold, Call, or Raise)"
        input = gets.chomp.downcase

        until ['fold', 'call', 'raise'].include?(input)
            puts "Invalid action. Please try again."
            input = get_player_action
        end
        
        input.to_sym
    end

    def get_discard_input
        puts "#{@name}, enter card names to discard separated by a space (e.g.: 2H 4D QC)"
        input = gets.chomp.upcase
        card_names = input.split(" ")
        
        card_names
    end

    def get_bet_input
        puts "Enter an amount:"
        input = gets.chomp

        begin
            input = Integer(input)
        rescue => exception
            puts "Invalid Amount. Please try again."
            get_bet_input
        end

        input
    end

    private
    def get_cards(card_names)
        cards = []
        card_names.each do |name|
            @hand.cards.each do |card|
                if card.name == name
                    cards << card
                    break
                end
            end
        end

        if cards.length != card_names.length
            raise StandardError.new("One or more cards for discard are invalid.")
        end

        cards
    end
end