# frozen_string_literal: true

require_relative '../models/user'
require_relative '../models/dealer'

module UserActions
  USER_INIT = 'Enter you name, please: '
  DEALER_NAME = 'Dealer'
  EXPECTED_VALUE = 21

  private

  def init_user
    user_name = init_user_dialog
    User.new(user_name)
  end

  def init_user_dialog
    print USER_INIT
    gets.chomp.strip
  end

  def init_dealer
    Dealer.new(DEALER_NAME)
  end

  def one_more_card_user
    one_more_card(user)
  end

  def one_more_card(usr)
    usr.add_card_to_hand(deck.take_card)
  end

  def pass
    # just skip
  end

  def dealer_pass
    dealer.msg = 'Message: Pass!'
  end

  def extract_dealer_hand
    if dealer.hand_is_full?
      dealer.msg = "Sum: #{dealer.hand_sum}"
      dealer.hand_str
    else
      dealer.hand_str_secret
    end
  end

  def find_the_winner(users)
    if (winner = winner_logic(users))
      winner.return_bet
      winner.win
      winner
    else # draw
      user.return_bet
      dealer.return_bet
      nil
    end
  end

  def winner_logic(users)
    return if users.map(&:hand_sum).uniq.count < users.count # draw check

    users.each { |usr| usr.result = (EXPECTED_VALUE - usr.hand_sum).abs }
    winner = return_winner_if_one_over(users)
    winner || users.min_by(&:result)
  end

  def return_winner_if_one_over(users)
    not_over_users = users.reject(&:over?)
    not_over_users.count == 1 ? not_over_users.first : nil
  end
end
