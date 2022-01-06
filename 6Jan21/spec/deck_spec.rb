require 'deck'
require 'rspec'

describe Deck do
    subject { Deck.new }

    describe '#initialize' do
        it 'starts @cards with an array of 52 cards' do
            subject_cards = subject.instance_variable_get(:@cards)
            expect(subject_cards.length).to eq(52)
        end

        it '@cards array has been shuffled into a random order' do
            original_cards = subject.instance_variable_get(:@cards)
            sorted = original_cards.sort
            expect(original_cards).to_not eq(sorted)
        end
    end


    describe '#take' do
        let(:card_1) { double("card_1") }
        let(:card_2) { double("card_2") }

        context 'when @cards is not empty' do
            it 'removes the last element from @cards and returns it' do
                subject.instance_variable_set(:@cards, [card_1, card_2])
                expect(subject.take).to eq(card_2)
                expect(subject.instance_variable_get(:@cards).length).to eq(1)
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

end