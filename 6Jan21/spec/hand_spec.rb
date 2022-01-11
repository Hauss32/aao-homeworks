require 'hand'
require 'rspec'

describe Hand do
    subject { Hand.new }
    let(:three_hearts) { double("card", :name => '3H') }
    let(:nine_spades) { double("card", :name => '9S') }
    let(:ace_clubs) { double("card", :name => 'AC') }
    let(:king_clubs) { double("card", :name => 'KC') }
    let(:queen_diamonds) { double("card", :name => 'QD') }

    let(:some_cards) { [three_hearts, nine_spades, ace_clubs, king_clubs, queen_diamonds] }

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
end