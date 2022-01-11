require_relative 'Card'

class Hand
    attr_reader :cards

    def initialize
        @cards = []
    end

    def add_cards(cards_arr)
        if cards_arr.length + @cards.length > 5
            raise StandardError.new("Hand cannot have more than 5 cards.")
        end

        @cards += cards_arr

        true
    end

    def discard(cards_arr)
        cards_arr.each do |card|
            if @cards.include?(card)
                @cards.delete(card)
            else
                raise StandardError.new("One or more cards to discard are invalid.")
            end
        end

        true
    end
end