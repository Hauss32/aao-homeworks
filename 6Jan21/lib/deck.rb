require_relative 'card'

class Deck
    def initialize
        @cards = []

        make_deck
        shuffle
    end

    def take
        raise StandardError.new("No cards left to take!") if @cards.empty?

        @cards.pop
    end

    private
    def make_deck
        suits = ['H', 'S', 'D', 'C']
        cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

        cards.each do |card_val|
            suits.each do |suit|
                @cards << Card.new(card_val + suit)
            end
        end
    end

    def shuffle
        @cards.shuffle!
    end
end