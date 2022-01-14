require_relative 'hand.rb'

class Player
    attr_reader :hand, :bank

    def initialize(amount)
        @hand = nil
        @bank = amount
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

    def deduct_bet(amount)
        if @bank - amount < 0
            raise ArgumentError.new("Insufficient bank to support that bet.")
        end

        @bank -= amount

        amount
    end

    def receive_winnings(amount)
        @bank += amount

        true
    end

    def fold
        @hand = nil
    end

    def get_action_input
        puts "Enter your move (type: Fold, Call, or Raise)"
        input = gets.chomp.downcase

        until ['fold', 'call', 'raise'].include?(input)
            puts "Invalid action. Please try again."
            input = get_player_action
        end
        
        input.to_s
    end

    def get_discard_input
        puts "Enter card names to discard separated by a space (e.g.: 2H 4D QC)"
        input = gets.chomp.upcase
        card_names = input.split(" ")
        
        card_names
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