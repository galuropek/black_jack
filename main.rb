# frozen_string_literal: true

# require_relative 'models/bank'
require_relative 'models/card'
require_relative 'models/card_deck'
# require_relative 'models/dealer'
# require_relative 'models/user'

require_relative 'modules/user_actions'
require_relative 'modules/menu'

class Main
  include UserActions
  include Menu

  attr_reader :user, :dealer, :deck

  TABLE = '
******************
*** Black Jack ***
******************

Game: %<game>s        Round: %<round>s
------------------------------------
		Dealer:
Bank: %<dealer_bank>s		Bet: %<bet>s
Hand: %<dealer_hand>s
Message: %<dealer_message>s
------------------------------------
		%<user_name>s:
Bank: %<user_bank>s		Bet: %<bet>s
Hand: %<user_hand>s
Your sum: %<user_sum>s
------------------------------------
'
  GAME_SETTINGS = {
    bank: 100,
    bet: 10
  }.freeze

  def initialize
    @user = init_user
    @dealer = init_dealer
    @deck = CardDeck.new
    @game = 1
    @round = 1
  end

  def start_game
    prepare_to_game(dealer)
    prepare_to_game(user)
    # user.add_card_to_hand(deck.take_card)
    # dealer.add_card_to_hand(deck.take_card)
    # user.show_hand
    # dealer.show_hand
    loop do
      system 'clear'
      show_table
      show_menu
      execute_user_action
      execute_dealer_action
    end
  end

  private

  attr_writer :user, :dealer, :deck

  def prepare_to_game(usr)
    usr.init_bank(GAME_SETTINGS[:bank], GAME_SETTINGS[:bet])
    usr.init_hand(deck.take_card, deck.take_card)
    usr.place_bet
  end

  def show_table
    puts TABLE % table_params
  end

  # rubocop:disable Metrics/MethodLength
  def table_params
    {
      game: @game,
      round: @round,
      dealer_bank: dealer.bank,
      bet: "#{GAME_SETTINGS[:bet]} $",
      dealer_hand: dealer.hand_str,
      dealer_message: dealer.msg,
      user_name: user.name,
      user_bank: user.bank,
      user_hand: user.hand_str,
      user_sum: user.hand_sum
    }
  end

  # rubocop:enable Metrics/MethodLength

  def execute_user_action
    @round += 1
    send(user_action, user)
  rescue NoMethodError => e
    puts "ERROR: #{e.message}"
    puts INCORRECT_INPUT
    retry
  end

  def execute_dealer_action
    dealer.need_card? ? one_more_card(dealer) : dealer_pass
  end
end

Main.new.start_game
