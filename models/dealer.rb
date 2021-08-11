# frozen_string_literal: true

require_relative 'base_user'

class Dealer < BaseUser
  attr_accessor :msg

  EXPECTED_MAX_VALUE = 17

  def clear_msg!
    self.msg = nil
  end

  def need_card?
    hand_sum < EXPECTED_MAX_VALUE
  end

  def hand_str_secret
    hand.map { |_| '*' }.join(' ')
  end
end
