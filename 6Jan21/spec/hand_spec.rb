require 'hand'
require 'rspec'

describe Hand do
    subject { Hand.new }
    let(:three_hearts) { double("card", :name => '3H') }
    let(:three_diamonds) { double("card", :name => '3D') }
    let(:three_spades) { double("card", :name => '3S') }
    let(:three_clubs) { double("card", :name => '3C') }
    let(:nine_spades) { double("card", :name => '9S') }
    let(:nine_clubs) { double("card", :name => '9C') }
    let(:queen_diamonds) { double("card", :name => 'QD') }
    let(:king_clubs) { double("card", :name => 'KC') }
    let(:ace_clubs) { double("card", :name => 'AC') }
    let(:ace_hearts) { double("card", :name => 'AH') }

    let(:some_cards) { [three_hearts, nine_spades, queen_diamonds, king_clubs, ace_clubs] }

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
        let(:jack_spades) { double("card", :name => 'JS') }
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

    describe '#high_card' do
        it 'returns a sorted array of 5 cards' do
            expect(subject.add_cards(some_cards)).to eq(some_cards)
        end
    end

    describe '#pair' do
        let(:pair_hand) do
            hand = Hand.new
            hand.add_cards([three_hearts, three_diamonds, ace_clubs])
            hand
        end

        it 'returns an array of 2 cards when 2 of the same card values exist in @cards' do
            expect(pair_hand.pair).to include(three_hearts, three_diamonds)
            expect(pair_hand.pair.length).to eq(2)
        end

        it 'returns an empty array when no 2 of the same card values exist in @cards' do
            my_pair = pair_hand
            my_pair.discard(three_hearts)
            expect(my_pair.pair).to be_empty
        end
    end

    describe '#two_pair' do
        let(:two_pair_cards) { [three_hearts, three_diamonds, ace_clubs, ace_hearts] }
        let(:two_pair_hand) do
            hand = Hand.new
            hand.add_cards(two_pair_cards)
            hand
        end

        it 'returns an array of sub-arrays of 2 cards when 2 pairs of alike values exist in @cards' do
            expect(two_pair_hand.two_pair.length).to eq(2)
            expect(two_pair_hand.two_pair.flatten).to include(*two_pair_cards)
        end
        
        it 'returns an empty array when no 2 pairs of alike values exist in @cards' do
            my_two_pair = two_pair_hand
            my_two_pair.discard(three_hearts)
            expect(my_two_pair.two_pair).to be_empty
        end
    end

    describe '#three_of_a_kind' do
        it 'returns an array of 3 cards when 3 of the same card values exist in @cards'
        
        it 'returns an empty array when no 3 of the same card values exist in @cards'
    end

    describe '#straight' do
        it 'returns a sorted array of 5 cards when 5 consecutive card values exist in @cards'
        
        it 'returns an empty array when no 5 consecutive card values exist in @cards'
    end

    describe '#flush' do
        it 'returns a sorted array of 5 cards when all 5 cards in @cards share the same suit'
        
        it 'returns an empty array when 2 or more suits exist in @cards'
    end

    describe '#full_house' do
        it 'returns an array of 2 sub-arrays (3 cards, 2 cards) when @cards contains 3 of one value, and 2 of another'
        
        it 'returns an empty array when @cards does not contain 3 of one value, and 2 of another'
    end

    describe '#four_of_a_kind' do
        it 'returns an array of 4 cards when 4 of the same card values exist in @cards'
        
        it 'returns an empty array when no 3 of the same card values exist in @cards'
    end

    describe '#straight_flush' do
        it 'returns a sorted array of 5 cards when 5 consecutive card values of the same suit exist in @cards'
        
        it 'returns an empty array when no 5 consecutive card values of the same suit exist in @cards'
    end

    describe '#royal_flush' do
        it 'returns a sorted array of 5 cards when 5 consecutive face-card values of the same suit exist in @cards'
        
        it 'returns an empty array when no 5 consecutive face-card values of the same suit exist in @cards'
    end
end