require_relative 'bank'

class BaseUser
  attr_reader :name, :bank, :hand

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

  def hand_sum
    hand.map(&:numeric).sum
  end

  def show_hand
    hand.each { |card| print "#{card} " }
  end

  def win
    bank.win_bet
  end

  def lose
    bank.lose_bet
  end

  def to_s
    name
  end

  protected

  attr_writer :name, :bank, :hand

end