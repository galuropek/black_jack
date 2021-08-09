class Bank
  attr_reader :balance, :bet, :currency

  ERRORS = {
    bad_balance: 'The balance is less than the bet!'
  }

  def initialize(balance, bet, currency = '$')
    @balance = balance
    @currency = currency
    @bet = bet
  end

  def win_bet
    @balance += @bet
  end

  def lose_bet
    validate_balance!
    @balance -= @bet
  end

  def to_s
    "#{@balance} #{@currency}"
  end

  private

  def validate_balance!
    raise ERRORS[:bad_balance] if @balance < @bet
  end
end