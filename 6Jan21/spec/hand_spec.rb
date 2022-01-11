require 'hand'
require 'rspec'

describe Hand do
    subject { Hand.new }
    let(:three_hearts) { double("card", :name => '3H') }
    let(:three_diamonds) { double("card", :name => '3D') }
    let(:three_spades) { double("card", :name => '3S') }
    let(:three_clubs) { double("card", :name => '3C') }
    let(:ten_hearts) { double("card", :name => '10H') }
    let(:ten_clubs) { double("card", :name => '10C') }
    let(:jack_spades) { double("card", :name => 'JS') }
    let(:jack_clubs) { double("card", :name => 'JC') }
    let(:jack_hearts) { double("card", :name => 'JH') }
    let(:queen_hearts) { double("card", :name => 'QH') }
    let(:king_hearts) { double("card", :name => 'KH') }
    let(:ace_hearts) { double("card", :name => 'AH') }

    let(:some_cards) { [three_hearts, ten_hearts, jack_clubs, king_hearts, ace_hearts] }

    describe '#initialize' do
        it 'initializes @cards to an empty array' do
            expect(subject.cards).to be_empty
        end
    end

    describe '#add_cards' do
        it 'accepts an array of new cards and adds them to @cards' do
            subject.add_cards(some_cards)
            expect(subject.cards).to eq(some_cards)
        end

        it 'throws an error when @cards already has 5 elements' do
            subject.add_cards(some_cards)
            expect { subject.add_cards(some_cards) }.to raise_error("Hand cannot have more than 5 cards.")
        end
    end

    describe '#discard' do
        before(:each) { subject.add_cards(some_cards) }

        it 'deletes an array of cards based on the card name' do
            hand_cards = some_cards.dup
            cards_to_remove = hand_cards.slice!(2..-1)
            subject.discard(cards_to_remove)

            expect(subject.cards).to eq(hand_cards)
        end

        it 'throws an error when one or more cards is not in the hand' do
            expect { subject.discard([three_hearts, jack_spades]) }.to raise_error("One or more cards to discard are invalid.")
        end
    end

    describe '#<=>' do
        let(:pair_hand) do
            hand = Hand.new
            hand.add_cards( [three_hearts, ten_hearts, jack_spades, king_hearts, ace_hearts] )
            hand
        end

        let(:two_pair_hand) do
            hand = Hand.new
            hand.add_cards( [three_hearts, ten_hearts, jack_spades, king_hearts, ace_hearts] )
            hand
        end

        let(:three_of_a_kind_hand) do
            hand = Hand.new
            hand.add_cards( [three_hearts, ten_hearts, jack_spades, king_hearts, ace_hearts] )
            hand
        end

        let(:straight_hand) do
            hand = Hand.new
            hand.add_cards( [three_hearts, ten_hearts, jack_spades, king_hearts, ace_hearts] )
            hand
        end

        let(:flush_hand) do
            hand = Hand.new
            hand.add_cards( [three_hearts, ten_hearts, jack_spades, king_hearts, ace_hearts] )
            hand
        end

        let(:full_house_hand) do
            hand = Hand.new
            hand.add_cards( [three_hearts, ten_hearts, jack_spades, king_hearts, ace_hearts] )
            hand
        end

        let(:four_of_a_kind_hand) do
            hand = Hand.new
            hand.add_cards( [three_hearts, ten_hearts, jack_spades, king_hearts, ace_hearts] )
            hand
        end

        let(:straight_flush_hand) do
            hand = Hand.new
            hand.add_cards( [three_hearts, ten_hearts, jack_spades, king_hearts, ace_hearts] )
            hand
        end

        let(:royal_flush_hand) do
            hand = Hand.new
            hand.add_cards( [three_hearts, ten_hearts, jack_spades, king_hearts, ace_hearts] )
            hand
        end

        context 'one hand outranks another' do
            it 'returns true when royal flush beats straight flush'

            it 'returns false when straight flush loses to royal flush'

            it 'returns true when flush beats a straight'

            it 'returns false when a straight loses to a flush'

            it 'returns true when two-pair beats a pair'

            it 'returns false when a pair loses to two-pair'
            
        end

        context 'two hands share a rank, but hands are not equal' do
            it 'returns true when a King-high straight beats a Queen-high straight'

            it 'returns false when a Queen-high straight loses to a King-high straight'

            it 'returns true when a two-pair of Jacks/Threes beats a two-pair of Tens/Threes'

            it 'returns false when a two-pair of Tens/Threes loses to a two-pair of Jacks/Threes'

            it 'returns true when a two-pair of Jacks/Threes with Ace-high-card beats a two-pair of Jacks/Threes with 10-high-card'

            it 'returns false when a two-pair of Jacks/Threes with 10-high-card beats a two-pair of Jacks/Threes with Ace-high-card'

            it 'returns true when Ace-high-card beats Queen-high-card'

            it 'returns false when Queen-high-card loses Ace-high-card'

            it 'returns true when Ace-high-card with King-second-high beats Ace-high-card with 10-second-high'

            it 'returns false when Ace-high-card with 10-second-high beats Ace-high-card with King-second-high'
            
        end

        context 'two hands share a rank, and are equal' do
            it 'returns false when a King-high straight beats a King-high straight'

            it 'returns true when a King-high straight equals a King-high straight'

            it 'returns false when a two-pair of Jacks/Threes with Ace-high-card beats a two-pair of Jacks/Threes with Ace-high-card'

            it 'returns true when a two-pair of Jacks/Threes with Ace-high-card equals a two-pair of Jacks/Threes with Ace-high-card'

            it 'returns false when a high-card beats an equal high-card hand'

            it 'returns true when a high-card equals an equal high-card hand'
            
        end
    end


end