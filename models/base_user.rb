# frozen_string_literal: true

require_relative 'bank'

class BaseUser
  attr_accessor :result
  attr_reader :name, :bank, :hand

  EXPECTED_VALUE = 21

  def initialize(name)
    @name = name
  end

  def init_bank(balance, bet)
    self.bank = Bank.new(balance, bet)
  end

  def init_hand(first_card, second_card)
    self.hand = [first_card, second_card]
  end

  def add_card_to_hand(card)
    hand << card
  end

  def show_hand
    puts hand_str
  end

  def hand_sum
    sum = hand.map(&:numeric).sum
    return sum if sum <= EXPECTED_VALUE

    include_alternative_values? ? activate_alternative_mode : sum
  end

  def hand_str
    hand.join(' ')
  end

  def win
    bank.win_bet
  end

  alias return_bet win

  def lose
    bank.lose_bet
  end

  alias place_bet lose

  def over?
    hand_sum > EXPECTED_VALUE
  end

  def to_s
    name
  end

  protected

  attr_writer :name, :bank, :hand

  def activate_alternative_mode
    hand.each do |card|
      if card.alternative?
        card.alternative_mode!
        return hand_sum
      end
    end
  end

  def include_alternative_values?
    !!hand.find(&:alternative?)
  end
end
