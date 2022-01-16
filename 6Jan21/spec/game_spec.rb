require 'game'
require 'rspec'

#TODO Restrcture specs since actual Game class has changed so much

describe Game do
    subject { Game.new(['Some Player', 'Other Player'], 100) }
    let(:player_1) { double("player", :get_bet_input => 10, :get_discard_input => ['3H', '4D'], 
        :execute_bet => 10, :current_bet => 0, :discard_cards => true, :receive_cards => true, 
        :receive_winnings => true, :name => 'Some Name', :update_current_bet => true) }
    let(:card_1) { double("card") }
    let(:deck) { double("deck", :take => card_1) }

    describe '#initialize' do
        it 'sets @players to an array of Players from the player names provided' do
            expect(subject.players.length).to eq(2)
            expect(subject.players.all? { |p| p.is_a?(Player) }).to be true
        end

        it 'initializes @pot to a value of 0' do
            expect(subject.pot).to eq(0)
        end

        it 'initializes @deck to a new Deck' do
            expect(subject.deck).to be_a(Deck)
        end

        it 'initializes @next_player to the first player in @players' do
            players = subject.players
            expect(subject.next_player).to eq(players[0])
        end

        it 'initializes @current_bet to 0' do
            expect(subject.current_bet).to eq(0)
        end
    end

    describe '#take_bet' do
        before(:each) do
            subject.instance_variable_set(:@next_player, player_1)
        end

        it 'prompts a player for a bet' do
            expect(subject.next_player).to receive(:get_bet_input)
            subject.take_bet(subject.next_player)
        end

        it 'sets the @current_bet to bet value' do
            bet_amount = subject.next_player.get_bet_input
            subject.take_bet(subject.next_player)
            expect(subject.current_bet).to eq(bet_amount)
        end

        it 'increases @pot by bet value' do
            bet_amount = subject.next_player.get_bet_input
            subject.take_bet(subject.next_player)
            expect(subject.pot).to eq(bet_amount)
        end
    end

    describe '#take_raise' do
        before(:each) do
            subject.instance_variable_set(:@next_player, player_1)
            subject.instance_variable_set(:@pot, 5)
            subject.instance_variable_set(:@current_bet, 5)
        end

        it 'prompts a player for a raise' do
            expect(subject.next_player).to receive(:get_bet_input)
            subject.take_raise(subject.next_player)
        end

        it 'collects a player raise and adds it to @pot' do
            subject.take_raise(subject.next_player)
            expect(subject.pot).to eq(15)
        end

        it 'sets the @current_bet to bet value' do
            subject.take_raise(subject.next_player)
            expect(subject.current_bet).to eq(10)
        end
    end

    describe '#do_discard' do
        it 'accepts a player as an argument' do
            expect { subject.do_discard(player_1) }.to_not raise_error
        end

        it 'prompts player for cards to discard' do
            expect(player_1).to receive(:get_discard_input)
            subject.do_discard(player_1)
        end

        it 'chosen cards are removed from players hand' do
            expect(player_1).to receive(:discard_cards)
            subject.do_discard(player_1)
        end
        
        it 'replaces discarded cards for the player' do
            expect(player_1).to receive(:receive_cards)
            subject.do_discard(player_1)
        end

        it 'replaces discarded cards with cards from the @deck' do
            subject.instance_variable_set(:@deck, deck)
            expect(deck).to receive(:take).exactly(2).times
            subject.do_discard(player_1)
        end
    end

    describe '#pay_winners' do
        it 'accepts a player and an amount as arguemnts' do
            expect { subject.pay_winners([player_1]) }.to_not raise_error
        end

        it 'increases the players bank by the amount' do
            expect(player_1).to receive(:receive_winnings)
            subject.pay_winners([player_1])
        end
    end
    
    describe '#reset_deck' do
        it 'sets the @deck to a new Deck instance' do
            current_deck = subject.deck
            subject.reset_deck
            expect(subject.deck).to be_a(Deck)
            expect(subject.deck).to_not be(current_deck)
        end
    end
end