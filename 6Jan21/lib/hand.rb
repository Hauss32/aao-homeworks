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

    attr_reader :cards, :count_card_values_hash

    def initialize
        @cards = []
        @count_card_values_hash = {}
    end

    def <=>(other_hand)
        compare_ranks = self.hand_rank <=> other_hand.hand_rank
        return compare_ranks unless compare_ranks == 0
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
    
    # private
    def multi_cards_compare(other_hand)
        hand_multi_card_vals = get_sorted_multi_count_vals(self)
        other_hand_multi_card_vals = get_sorted_multi_count_vals(other_hand)

        hand_compare_result = card_vals_compare(hand_multi_card_vals, other_hand_multi_card_vals)

        hand_compare_result
    end

    def single_cards_compare(other_hand)
        hand_single_card_vals = get_sorted_single_count_vals(self)
        other_hand_single_card_vals = get_sorted_single_count_vals(other_hand)
        
        hand_compare_result = card_vals_compare(hand_single_card_vals, other_hand_single_card_vals)

        hand_compare_result
    end

    def card_vals_compare(hand_vals_sorted, other_hand_vals_sorted)
        compare_result = 0

        (hand_vals_sorted.length).times do
            val = hand_vals_sorted.pop
            other_val = other_hand_vals_sorted.pop
            compare_val = val <=> other_val

            next if compare_val == 0

            compare_result = compare_val
            break
        end

        compare_result
    end

    def get_sorted_multi_count_vals(hand)
        multi_cards = hand.count_card_values_hash.select { |val, count| count > 1 }
        # sort first by count, then by card value
        multi_cards_sorted = multi_cards.sort_by { |val, count| [count, val] }
        multi_card_vals_sorted = multi_cards_sorted.map { |card| card[0] }

        multi_card_vals_sorted
    end

    def get_sorted_single_count_vals(hand)
        single_cards = hand.count_card_values_hash.select { |val, count| count == 1 }
        single_card_vals_sorted = single_cards.keys.sort

        single_card_vals_sorted
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