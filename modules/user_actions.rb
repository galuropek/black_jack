# frozen_string_literal: true

require_relative '../models/user'
require_relative '../models/dealer'

module UserActions
  DEALER_NAME = 'Дилер'
  MESSAGE = {
    user_init: 'Enter you name, please: '
  }.freeze

  private

  def init_user
    user_name = init_user_dialog
    User.new(user_name)
  end

  def init_dealer
    Dealer.new(DEALER_NAME)
  end

  def init_user_dialog
    print MESSAGE[:user_init]
    gets.chomp.strip
  end

  def one_more_card(usr)
    usr.add_card_to_hand(deck.take_card)
  end

  def pass(user)
    # just skip
  end

  def dealer_pass
    dealer.msg = 'Pass!'
  end
end
