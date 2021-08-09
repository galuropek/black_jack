# frozen_string_literal: true

class Card
  attr_reader :value, :suit, :numeric, :alternative_value

  def initialize(value, suit, numeric, alternative_value = nil)
    @alternative_value = alternative_value
    @numeric = numeric
    @value = value
    @suit = suit
  end

  def to_s
    "#{@value}#{@suit}"
  end
end
