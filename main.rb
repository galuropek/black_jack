# frozen_string_literal: true

require_relative 'models/card'
require_relative 'models/card_deck'

require_relative 'modules/user_actions'
require_relative 'modules/menu'

class Main
  include UserActions
  include Menu

  attr_reader :user, :dealer, :deck

  DRAW = 'not found !!! It`s a DRAW '
  GAME_SETTINGS = { bank: 100, bet: 10 }.freeze

  def initialize
    @user = init_user
    @dealer = init_dealer
    @game = 1
    @round = 1
  end

  def start_game
    prepare_to_game(dealer)
    prepare_to_game(user)

    loop do
      clear_table
      @round >= 3 || user.hand_is_full? ? end_game : play_game
    end
  end

  private

  attr_writer :user, :dealer, :deck

  # game steps

  def play_game
    show_table
    show_menu(play_menu)
    user_action = execute_user_action(play_menu)
    execute_dealer_action if user_action != :end_game
  end

  def end_game
    dealer.msg = "Sum: #{dealer.hand_sum}"
    clear_table
    winner = find_the_winner([user, dealer])
    winner_logic(winner)
    show_result(winner)
    show_menu(end_game_menu)
    execute_user_action(end_game_menu)
  end

  def next_game
    @round = 1
    @game += 1
    prepare_to_first_round(user)
    prepare_to_first_round(dealer)
    dealer.clear_msg!
  end

  # game logic

  def prepare_to_game(usr)
    usr.init_bank(GAME_SETTINGS[:bank], GAME_SETTINGS[:bet])
    prepare_to_first_round(usr)
  end

  def prepare_to_first_round(usr)
    @deck = CardDeck.new
    usr.init_hand(deck.take_card, deck.take_card)
    usr.place_bet
  end

  def execute_user_action(menu)
    @round += 1
    user_action = user_choice(menu)
    send user_action
    user_action
  end

  def execute_dealer_action
    dealer.need_card? && !dealer.hand_is_full? ? one_more_card(dealer) : dealer_pass
  end

  def winner_logic(winner)
    if winner
      winner.return_bet
      winner.win
      winner
    else # draw
      user.return_bet
      dealer.return_bet
      nil
    end
  end

  # game`s table activities

  def clear_table
    system 'clear'
  end

  def show_table
    bet_info = "Bet: #{GAME_SETTINGS[:bet]} $"
    puts TABLE % table_params(dealer.hand_str_secret, bet_info)
  end

  def show_result(winner)
    result = "Winner: #{winner || DRAW} !!!"
    puts TABLE % table_params(dealer.hand_str, nil, result)
  end

  # rubocop:disable Metrics/MethodLength
  def table_params(dealer_hand, bet_info, result = nil)
    {
      game: @game,
      round: @round,
      result: result,
      dealer_bank: dealer.bank,
      bet: bet_info,
      dealer_hand: dealer_hand,
      dealer_message: dealer.msg || 'Message: Let`s play!',
      user_name: user.name,
      user_bank: user.bank,
      user_hand: user.hand_str,
      user_sum: user.hand_sum
    }
  end
  # rubocop:enable Metrics/MethodLength
end

Main.new.start_game
