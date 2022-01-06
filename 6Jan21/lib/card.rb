class Card
    include Comparable

    SUITS = { "H" => :Hearts, "S" => :Spades, "D" => :Diamonds, "C" => :Clubs }
    FACE_CARDS = { "J" => 11, "Q" => 12, "K" => 13, "A" => 14 }

    attr_reader :name, :value, :suit

    def initialize(name)
        @name = name
        @value = nil
        @suit = nil

        parse_name_and_set
    end

    def <=>(other)
        self.value <=> other.value
    end


    private
    def parse_name_and_set
        @suit = parse_suit
        @value = parse_value

    end

    def parse_suit
        suit_char = @name[-1]
        suit = Card::SUITS[suit_char]

        raise ArgumentError.new("Card string provided is not recognized.") unless suit

        suit
    end

    def parse_value
        value_str = @name[0...-1]
        value = nil
        bad_val_error = ArgumentError.new("Card string provided is not recognized.")

        if Card::FACE_CARDS.has_key?(value_str)
            value = Card::FACE_CARDS[value_str]
        else
            begin
                value = Integer(value_str)
            rescue
                raise bad_val_error
            end
        end
        
        raise bad_val_error unless (2..14).include?(value)

        value
    end
end