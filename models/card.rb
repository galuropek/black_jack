# frozen_string_literal: true

class Card
  attr_reader :value, :suit, :numeric, :alternative_value, :mode

  def initialize(value, suit, numeric, alternative_value = nil)
    @alternative_value = alternative_value
    @numeric = numeric
    @value = value
    @suit = suit
    @mode = :default
  end

  def alternative_mode!
    return unless @alternative_value

    @mode = :alternative
    @numeric = @alternative_value
  end

  def alternative?
    @alternative_value && @mode == :default
  end

  def to_s
    "#{@value}#{@suit}"
  end
end
