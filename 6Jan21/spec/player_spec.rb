require 'rspec'
require 'player'

describe Player do
    describe "#initialize" do
        it 'initializes @hand to nil'

        it 'accepts a number and initializes @bank with that number'
    end

    describe '#new_hand' do
        it 'sets @hand to a new Hand instance'
    end

    describe "#receive_cards" do
        it 'accepts an array of cards'

        it 'adds an array of cards to @hand'
    end

    describe '#discard_cards' do
        it 'accepts an array of card names'

        it 'discards each card from @hand'
    end

    describe '#bet_action' do
        it 'returns a bet value'

        context 'when action is initial bet' do
            it 'decreses @bank by initial bet value'
        end

        context 'when action is raise' do
            it 'decreses @bank by raise value'
        end

        context 'when action is fold' do
            it 'sets hand to nil'
        end
    end

    describe '#receive_winnings' do
        it 'accepts a number as an argument'

        it 'adds the number to the player @bank'
    end
end