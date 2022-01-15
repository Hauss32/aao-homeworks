require_relative 'deck'
require_relative 'player'

#TODO Add in features for all-in (split pots, etc.)
#TODO Update rendering to make game more playable (warning before showing cards, etc.)
#TODO Refactor this mess (decompose, update public interface, etc.)
#TODO Research: warning: already initialized constant
#TODO Research: warning: previous definition of

class Game
    attr_reader :players, :deck, :pot, :next_player, :current_bet
    ANTE_BET = 5

    def initialize(player_names, bank_amount)
        @players = player_names.map { |name| Player.new(name, bank_amount) }
        @deck = Deck.new
        @pot = 0
        @next_player = @players[0]  
        @current_bet = 0
        @remaining_round_players = @players
        @next_round_player = @next_player
    end

    def play
        until @players.length == 1
            puts "\n——————————"
            puts "New Round"
            puts "\n——————————"
            play_round
            next_round
        end

        puts "~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!"
        puts "#{@players[0].name} has won the game"
        puts "~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!"
    end

    def play_round
        deal_new_hands

        puts "\n——————————————————————————"
        puts "Time for first round bets!\n"

        do_ante_bet
        do_betting_round

        puts "\n——————————————————————————"
        puts "Time to discard and draw!"
        puts

        do_discard_round

        puts "\n———————————————————————————"
        puts "Time for second round bets!"
        puts

        reset_betting_round
        do_ante_bet #TODO allow player to check/call 0 on second round
        do_betting_round

        # compare
        # pay_winner
    end

    def print_round_info
        puts "\n——————————————————————————————"
        @remaining_round_players.each do |player|
            name = player.name
            bank = player.bank
            bet = player.current_bet
            cards = player.cards.sort.map(&:name).join(", ")
            puts "#{name}: Bank: #{bank} Bet: #{bet} Cards: #{cards}"
        end
        puts "\nCurrent Bet: #{@current_bet}"
        puts "Pot Size: #{@pot}"
        puts "Players in Round: #{@remaining_round_players.map(&:name).join(", ")}"
        puts
    end

    def do_ante_bet
        @next_round_player.execute_bet(Game::ANTE_BET)
        @next_round_player.update_current_bet(Game::ANTE_BET)
        @current_bet = Game::ANTE_BET
        @pot += Game::ANTE_BET
        set_round_next_player(@next_round_player)
    end

    def do_betting_round
        done_betting = false

        until done_betting
            print_round_info
            action = @next_round_player.get_action_input
            do_player_action(@next_round_player, action)
            set_round_next_player(@next_round_player)
            filter_round_players
            done_betting = betting_round_done?
        end
        
    end

    def do_discard_round
        @remaining_round_players.each { |player| do_discard(player) }
    end

    def do_player_action(player, action)
        case action
        when :fold
            player.fold

            nil
        when :call
            amount = @current_bet - player.current_bet
            return nil if amount == 0

            if amount > player.bank #TODO: add actual all-in logic later
                puts "#{player.name} is all-in!"
                player.execute_bet(player.bank)
                @pot += player.bank
                player.update_current_bet(@current_bet)
            else
                player.execute_bet(amount)
                @pot += amount
                player.update_current_bet(@current_bet)
            end

            nil
        when :raise
            take_raise(player)

            nil
        else
            nil
        end
    end

    def do_discard(player)
        cards = player.get_discard_input

        begin
            player.discard_cards(cards)
        rescue => exception
            puts exception
            do_discard(player)
        end

        new_cards = deal_cards(cards.length)

        player.receive_cards(new_cards)
    end

    def set_round_next_player(curr_player)
        curr_idx = @remaining_round_players.index(curr_player)
        next_idx = (curr_idx + 1) % @remaining_round_players.length

        @next_round_player = @remaining_round_players[next_idx]
    end

    def filter_round_players
        @remaining_round_players.reject! { |player| player.hand.nil? }
    end

    def betting_round_done?
        @remaining_round_players.all? { |player| player.current_bet == @current_bet }
    end

    def take_bet(player)
        puts "#{player.name}, how much would you like to bet?"
        bet_amount = player.get_bet_input

        begin
            player.execute_bet(bet_amount)
            @pot += bet_amount
            @current_bet = bet_amount
            player.update_current_bet(bet_amount)
        rescue => exception
            puts exception
            take_bet(player)
        end

        bet_amount
    end

    def take_raise(player)
        puts "\n#{player.name}, how much would you like to raise the bet to?"
        bet_amount = player.get_bet_input

        until bet_amount > @current_bet
            puts "A raise needs to be greater than the current bet."
            bet_amount = player.get_bet_input
        end

        begin
            players_current_bet = player.current_bet
            raise_amount = bet_amount - players_current_bet
            player.execute_bet(raise_amount)
            @pot += raise_amount
            @current_bet = bet_amount
            player.update_current_bet(bet_amount)
        rescue => exception
            puts exception
            take_raise(player)
        end

        bet_amount
    end

    def do_discard(player)
        cards = player.get_discard_input

        begin
            player.discard_cards(cards)
        rescue => exception
            puts exception
            do_discard(player)
        end

        new_cards = deal_cards(cards.length)

        player.receive_cards(new_cards)
    end

    def pay_winner(player, amount)
        player.receive_winnings(amount)

        true
    end

    def reset_deck
        @deck = Deck.new
    end

    def deal_new_hands
        @players.each do |player|
            player.new_hand
            new_cards = deal_cards(5)
            player.receive_cards(new_cards)
        end
    end

    private
    def deal_cards(amount)
        cards = []
        amount.times { cards << @deck.take }

        cards
    end

    def remove_players
        @players.each { |player| @players.delete(player) if player.bank == 0 }
    end

    def reset_betting_round
        @players.each { |player| player.update_current_bet(0) }
        @current_bet = 0
        @next_round_player = @remaining_round_players[0]
    end

    def next_round
        @pot = 0
        filter_bankrupt_players
        @remaining_round_players = players
        reset_betting_round
        @next_player = @next_round_player #TODO Smarter next_player logic

    end

    def filter_bankrupt_players
        @players.reject! { |player| player.bank < Game::ANTE_BET }
    end


end