require 'card'
require 'rspec'

describe Card do
    subject { Card.new('4H') }

    describe '#initialize' do
        it 'accepts a card name string' do
            expect { Card.new('9C') }.to_not raise_error
        end

        it 'sets name instance variable' do
            expect(subject.name).to eq('4H')
        end

        it 'sets value instance variable' do
            expect(subject.value).to eq(4)
        end

        it 'sets suit instance variable' do
            expect(subject.suit).to eq(:Hearts)
        end

        it 'raises an error when argument value is not recognized' do
            expect { Card.new('18Z') }.to raise_error("Card value is not recognized.")
        end
    end

    describe '#<=>' do
        let(:bigger_card) { Card.new('JS') }
        let(:equiv_bigger_card) { Card.new('JD') }

        it 'correctly compares a larger card to a smaller card value' do
            expect(bigger_card > subject).to be true
        end

        it 'currently equates cards of the same value' do
            expect(bigger_card == equiv_bigger_card).to be true
        end
    end
end