require 'rspec'
require 'player'

describe Player do
    subject { Player.new(100) }

    let(:card_1) { double("Card", :name => '3H') }
    let(:card_2) { double("Card", :name => '9D') }
    let(:card_3) { double("Card", :name => 'AS') }
    let(:some_cards) { [card_1, card_2, card_3] }
    
    let(:Hand) { class_double("Hand") }
    let(:empty_hand) { double("hand", :add_card => true) }
    let(:hand_with_cards) { double("hand", :cards => some_cards, :discard => true) }

    describe "#initialize" do
        it 'initializes @hand to nil' do
            expect(subject.hand).to be_nil
        end

        it 'accepts a number and initializes @bank with that number' do
            expect(subject.bank).to eq(100)
        end
    end

    describe '#new_hand' do
        it 'sets @hand to a new Hand instance' do
            subject.new_hand
            expect(subject.hand).to be_a(Hand)
        end
    end

    describe "#receive_cards" do
        before(:each) { subject.instance_variable_set(:@hand, empty_hand) }

        it 'accepts an array of cards' do
            expect { subject.receive_cards(some_cards) }.to_not raise_error
        end

        it 'adds an array of cards to @hand' do
            num_cards_to_add = some_cards.length
            expect(subject.hand).to receive(:add_card).exactly(num_cards_to_add).times
            subject.receive_cards(some_cards)
        end
    end

    describe '#discard_cards' do
        let(:card_names) { ['9D', '3H'] }
        before(:each) { subject.instance_variable_set(:@hand, hand_with_cards) }

        it 'accepts an array of card names' do
            expect { subject.discard_cards(card_names) }.to_not raise_error
        end

        it 'discards each card from @hand' do
            num_cards_to_discard = card_names.length
            subject.instance_variable_set(:@hand, hand_with_cards)
            expect(subject.hand).to receive(:discard).exactly(num_cards_to_discard).times
            subject.discard_cards(card_names)
        end
    end

    describe '#deduct_bet' do
        it 'accepts an amount to deduct from the bank' do
            expect { subject.deduct_bet(10) }.to_not raise_error
        end

        it 'returns a bet value' do
            expect(subject.deduct_bet(25)).to eq(25)
        end

        it 'deducts the amount from players @bank' do
            subject.deduct_bet(15)
            expect(subject.bank).to eq(85)
        end

        it 'throws an error when bet is greater than the @bank value' do
            subject.deduct_bet(80)
            expect { subject.deduct_bet(50) }.to raise_error("Insufficient bank to support that bet.")
        end
    end

    describe '#receive_winnings' do
        it 'accepts a number as an argument' do
            expect { subject.receive_winnings(40) }.to_not raise_error
        end

        it 'adds the number to the player @bank' do
            subject.receive_winnings(50)
            expect(subject.bank).to eq(150)
        end
    end

    describe '#fold' do
        it 'sets the players @hand to nil' do
            subject.fold
            expect(subject.hand).to be_nil
        end
    end
end