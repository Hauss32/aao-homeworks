require 'deck'
require 'rspec'

describe Deck do
    subject { Deck.new }

    describe '#initialize' do
        it 'starts @cards with an array of 52 cards' do
            expect(subject.cards.length).to eq(52)
        end
    end


    describe '#take' do
        context 'when @cards is not empty' do
            it 'removes an element from @cards and returns it' do
                expect(subject.take).to be_a(Card)
            end
        end

        context 'when @cards is empty' do
            let(:empty_deck) { Deck.new }
            it 'raises an error' do
                empty_deck.instance_variable_set(:@cards, [])
                expect { empty_deck.take }.to raise_error("No cards left to take!")
            end
        end
    end

    describe '#shuffle' do
        it 'randomly reorders the @cards array' do
            original_cards = subject.cards.dup
            subject.shuffle
            expect(subject.cards).to_not eq(original_cards)
        end
    end

end