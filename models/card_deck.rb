# frozen_string_literal: true

require_relative 'card'

class CardDeck
  attr_reader :min, :deck

  SUITS = {
    diamonds: "\u2666",
    hearts: "\u2665",
    spades: "\u2660",
    clubs: "\u2663"
  }.freeze

  def initialize(min: 2)
    @min = min
    @deck = []
    init_deck
  end

  def take_card
    deck.delete(deck.sample)
  end

  def show_deck
    deck.each { |card| puts card }
  end

  private

  def init_deck
    init_numeric_cards
    init_dignity_cards
  end

  def init_numeric_cards
    min, max = card_variations[:numbers].values
    (min..max).each do |num|
      init_suit(value: num, numeric: num)
    end
  end

  def init_dignity_cards
    card_variations[:dignity].each do |_, value|
      init_suit(value)
    end
  end

  def init_suit(init_value)
    SUITS.each do |_, suit|
      value = init_value[:value]
      numeric = init_value[:numeric]
      alternative = init_value[:alternative]
      deck << Card.new(value, suit, numeric, alternative)
    end
  end

  def card_variations
    {
      numbers: { min: min, max: 10 },
      dignity: {
        jack: { value: 'J', numeric: 10 },
        queen: { value: 'Q', numeric: 10 },
        king: { value: 'K', numeric: 10 },
        ace: { value: 'A', numeric: 11, alternative: 1 }
      }
    }
  end
end
