require_relative 'deck'
require_relative 'player'

#TODO Add in features for all-in (split pots, etc.)
#TODO Refactor this mess

class Game
    attr_reader :players, :deck, :pot, :next_player, :current_bet

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

        end

        puts "~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!"
        puts "#{@players[0].name} has won the game"
        puts "~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!"
    end

    def play_round
        player_1 takes_bet
        until
            all_remaining_players.current_bet == @current_bet
            all_remaining_players.get_action
        end

        discard_round

        until
            all_remaining_players.current_bet == @current_bet
            all_remaining_players.get_action
        end

        compare
        pay_winner
    end

    def print_round_info
        @remaining_round_players.each do |player|
            name = player.name
            bank = player.bank
            bet = player.current_bet
            puts "\n#{name}: Bank: #{bank} Bet: #{bet}"
        end
        puts "\nCurrent Bet: #{@current_bet}"
        puts "Pot Size: #{@pot}"
        puts "Players in Round: #{@remaining_round_players.map(&:name).join(", ")}\n"
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

    def do_player_action(player, action)
        case action
        when :fold
            player.fold

            nil
        when :call
            amount = @current_bet - player.current_bet
            return if amount == 0

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
        puts "#{player.name} how much would you like to raise the bet to?"
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
        puts "Which cards would you like to discard?"
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


end