require_relative 'base_user'

class Dealer < BaseUser

  EXPECTED_MAX_VALUE = 17

  def need_card?
    hand_sum < EXPECTED_MAX_VALUE
  end
end