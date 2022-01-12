require_relative 'Card'

class Hand
    include Comparable

    HAND_RANKINGS = {
        :royal_flush => 10,
        :straight_flush => 9,
        :four_of_a_kind => 8,
        :full_house => 7,
        :flush => 6,
        :straight => 5,
        :three_of_a_kind => 4,
        :two_pair => 3,
        :pair => 2,
        :high_card => 1
    }

    attr_reader :cards

    def initialize
        @cards = []
        @count_card_values_hash = {}
    end

    def <=>(other_hand)

    end

    def add_card(card)
        if @cards.length == 5
            raise StandardError.new("Hand cannot have more than 5 cards.")
        end

        @cards << card

        true
    end

    def discard(card)
        @cards.each_with_index do |hand_card, idx|
            if hand_card.eql?(card)
                @cards.delete_at(idx)
                return true
            end
        end

        raise StandardError.new("One or more cards to discard are invalid.")
    end

    # private
    def hand_rank
        ranking_methods = Hand::HAND_RANKINGS.keys

        count_card_values

        ranking_methods.each do |method|
            has_hand_rank = self.send(method)

            if has_hand_rank
                rank_value = Hand::HAND_RANKINGS[method]
                return rank_value
            end
        end
    end

    def count_card_values
        @count_card_values_hash = Hash.new { |h, k| h[k] = 0 }

        @cards.each { |card| @count_card_values_hash[card.value] += 1 }

        true
    end

    def royal_flush
        has_royal_cards && flush ? true : false
    end

    def straight_flush
        straight && flush ? true : false
    end

    def four_of_a_kind
        four_count = @count_card_values_hash.select { |value, count| count == 4 }

        four_count.keys.empty? ? false : true
    end

    def full_house
        three_of_a_kind && pair ? true : false
    end

    def flush
        first_card_suit = @cards[0].suit
        all_same_suit = @cards.all? { |card| card.suit == first_card_suit }

        all_same_suit ? true : false
    end

    def straight
        card_vals = @count_card_values_hash.keys
        return false unless card_vals.length == 5

        card_vals.sort!

        (0...card_vals.length - 1).each do |idx|
            val = card_vals[idx]
            next_val = card_vals[idx + 1]

            return false unless next_val - val == 1
        end

        true
    end

    def three_of_a_kind
        three_count = @count_card_values_hash.select { |value, count| count == 3 }

        three_count.keys.empty? ? false : true
    end

    def two_pair
        find_pairs.keys.length > 1 ? true : false
    end

    def pair
        find_pairs.keys.length > 0 ? true : false
    end

    def high_card
        true #hand will always have high card
    end

    def has_royal_cards
        royal_card_vals = [10, 11, 12, 13, 14]
        card_vals = @cards.map(&:value).sort

        card_vals == royal_card_vals ? true : false
    end

    def find_pairs
        @count_card_values_hash.select { |value, count| count == 2 }
    end
end