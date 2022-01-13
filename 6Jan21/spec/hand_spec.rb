require 'hand'
require 'rspec'

describe Hand do
    subject { Hand.new }
    let(:three_hearts) { double("card", :name => '3H', :value => 3, :suit => :Hearts) }
    let(:three_diamonds) { double("card", :name => '3D', :value => 3, :suit => :Diamonds) }
    let(:three_spades) { double("card", :name => '3S', :value => 3, :suit => :Spades) }
    let(:three_clubs) { double("card", :name => '3C', :value => 3, :suit => :Clubs) }
    let(:eight_clubs) { double("card", :name => '8C', :value => 8, :suit => :Clubs) }
    let(:nine_clubs) { double("card", :name => '9C', :value => 9, :suit => :Clubs) }
    let(:nine_diaminds) { double("card", :name => '9D', :value => 9, :suit => :Diamonds) }
    let(:ten_hearts) { double("card", :name => '10H', :value => 10, :suit => :Hearts) }
    let(:ten_clubs) { double("card", :name => '10C', :value => 10, :suit => :Clubs) }
    let(:jack_spades) { double("card", :name => 'JS', :value => 11, :suit => :Spades) }
    let(:jack_diamonds) { double("card", :name => 'JD', :value => 11, :suit => :Diamonds) }
    let(:jack_clubs) { double("card", :name => 'JC', :value => 11, :suit => :Clubs) }
    let(:jack_hearts) { double("card", :name => 'JH', :value => 11, :suit => :Hearts) }
    let(:queen_hearts) { double("card", :name => 'QH', :value => 12, :suit => :Hearts) }
    let(:queen_clubs) { double("card", :name => 'QC', :value => 12, :suit => :Clubs) }
    let(:king_hearts) { double("card", :name => 'KH', :value => 13, :suit => :Hearts) }
    let(:king_clubs) { double("card", :name => 'KC', :value => 13, :suit => :Clubs) }
    let(:ace_hearts) { double("card", :name => 'AH', :value => 14, :suit => :Hearts) }
    let(:ace_clubs) { double("card", :name => 'AC', :value => 14, :suit => :Clubs) }

    let(:some_cards) { [three_hearts, ten_hearts, jack_clubs, king_hearts, ace_hearts] }

    describe '#initialize' do
        it 'initializes @cards to an empty array' do
            expect(subject.cards).to be_empty
        end
    end

    describe '#add_card' do
        it 'accepts a new card and adds it to @cards' do
            subject.add_card(jack_clubs)
            expect(subject.cards[0]).to eq(jack_clubs)
        end

        it 'throws an error when @cards already has 5 elements' do
            some_cards.each { |card| subject.add_card(card) }
            expect { subject.add_card(three_clubs) }.to raise_error("Hand cannot have more than 5 cards.")
        end
    end

    describe '#discard' do
        before(:each) { some_cards.each { |card| subject.add_card(card) } }

        it 'deletes a card from @cards' do
            hand_cards = some_cards.dup
            card_to_remove = hand_cards.pop
            subject.discard(card_to_remove)

            expect(subject.cards).to eq(hand_cards)
        end

        it 'does not delete other cards of the same value unless provided for discard' do
            subject.discard(ace_hearts)
            another_three_card = three_diamonds
            subject.add_card(another_three_card)
            subject.discard(another_three_card)
            expect(subject.cards.length).to be(4)
        end

        it 'throws an error when one or more cards is not in the hand' do
            expect { subject.discard([three_hearts, jack_spades]) }.to raise_error("One or more cards to discard are invalid.")
        end
    end

    describe '#<=>' do
        let(:two_pair_hand) do
            hand = Hand.new
            [three_hearts, three_clubs, ten_hearts, jack_spades, jack_hearts].each { |card| hand.add_card(card) }
            hand
        end

        let(:equal_two_pair_hand) do
            hand = Hand.new
            [three_spades, three_diamonds, ten_clubs, jack_clubs, jack_diamonds].each { |card| hand.add_card(card) }
            hand
        end

        let(:lesser_two_pair_hand) do
            hand = Hand.new
            [three_spades, three_diamonds, nine_clubs, jack_clubs, jack_diamonds].each { |card| hand.add_card(card) }
            hand
        end

        let(:straight_hand) do
            hand = Hand.new
            [nine_clubs, ten_hearts, jack_spades, queen_clubs, king_hearts].each { |card| hand.add_card(card) }
            hand
        end

        let(:equal_straight_hand) do
            hand = Hand.new
            [nine_diaminds, ten_clubs, jack_hearts, queen_hearts, king_clubs].each { |card| hand.add_card(card) }
            hand
        end

        let(:lesser_straight_hand) do
            hand = Hand.new
            [eight_clubs, nine_diaminds, ten_clubs, jack_hearts, queen_hearts].each { |card| hand.add_card(card) }
            hand
        end

        let(:flush_hand) do
            hand = Hand.new
            [three_hearts, ten_hearts, jack_hearts, king_hearts, ace_hearts].each { |card| hand.add_card(card) }
            hand
        end

        let(:ace_high_hand) do
            hand = Hand.new
            [three_hearts, ten_clubs, jack_hearts, king_clubs, ace_hearts].each { |card| hand.add_card(card) }
            hand
        end

        let(:equal_ace_high_hand) do
            hand = Hand.new
            [three_clubs, ten_hearts, jack_clubs, king_hearts, ace_clubs].each { |card| hand.add_card(card) }
            hand
        end

        let(:lesser_ace_high_hand) do
            hand = Hand.new
            [three_clubs, ten_hearts, jack_clubs, queen_hearts, ace_clubs].each { |card| hand.add_card(card) }
            hand
        end

        let(:lesser_high_hand) do
            hand = Hand.new
            [three_clubs, nine_diaminds, ten_hearts, jack_clubs, king_hearts].each { |card| hand.add_card(card) }
            hand
        end

        context 'one hand outranks another' do
            it 'returns true when flush beats a straight' do
                expect(flush_hand > straight_hand).to be true
            end

            it 'returns false when a straight loses to a flush' do
                expect(straight_hand > flush_hand).to be false
            end

            it 'returns false when flush ties a straight' do
                expect(flush_hand == straight_hand).to be false
            end           
        end

        context 'two hands share a rank, but hands are not equal' do
            it 'returns true when a King-high straight beats a Queen-high straight' do
                expect(straight_hand > lesser_straight_hand).to be true
            end

            it 'returns false when a Queen-high straight loses to a King-high straight' do
                expect(lesser_straight_hand > straight_hand).to be false
            end

            it 'returns false when a Queen-high straight ties to a King-high straight' do
                expect(lesser_straight_hand == straight_hand).to be false
            end
    
            it 'returns true when a two-pair of Jacks/Threes with 10-high-card 
                beats a two-pair of Jacks/Threes with 9-high-card' do
                    expect(two_pair_hand > lesser_two_pair_hand).to be true
                end

            it 'returns false when a two-pair of Jacks/Threes with 9-high-card 
                beats a two-pair of Jacks/Threes with 10-high-card' do
                    expect(lesser_two_pair_hand > two_pair_hand).to be false
                end

            it 'returns true when Ace-high-card with King-second-high-card 
                beats Ace-high-card with Queen-second-high-card' do
                    expect(ace_high_hand > lesser_ace_high_hand).to be true
                end

            it 'returns false when Ace-high-card with Queen-second-high-card 
                beats Ace-high-card with King-second-high-card' do
                    expect(lesser_ace_high_hand > ace_high_hand).to be false
                end

            it 'returns true when Ace-high-card beats Queen-high-card'  do
                expect(ace_high_hand > lesser_high_hand).to be true
            end
        end

        context 'two hands share a rank, and are equal' do
            it 'returns false when a King-high straight beats a King-high straight' do
                expect(straight_hand > equal_straight_hand).to be false
            end

            it 'returns true when a King-high straight equals a King-high straight' do
                expect(straight_hand == equal_straight_hand).to be true
            end

            it 'returns false when a two-pair of Jacks/Threes with 10-high-card 
                beats a two-pair of Jacks/Threes with 10-high-card' do
                    expect(two_pair_hand > equal_two_pair_hand).to be false
                end

            it 'returns true when a two-pair of Jacks/Threes with 10-high-card 
                equals a two-pair of Jacks/Threes with 10-high-card' do
                    expect(two_pair_hand == equal_two_pair_hand).to be true
                end

            it 'returns false when a high-card beats an equal high-card hand' do
                expect(ace_high_hand > equal_ace_high_hand).to be false
            end

            it 'returns true when a high-card equals an equal high-card hand' do
                expect(ace_high_hand == equal_ace_high_hand).to be true
            end
            
        end
    end


end