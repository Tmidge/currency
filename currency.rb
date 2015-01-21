class Currency
  attr_accessor :code, :amount
  def initialize(code, amount)
    @code = code
    @amount = amount
  end

  def +(other)
    Currency.new(amount + other.amount)
  end

  def ==(other)
    amount == other.amount
  end

  def -(other)
    Currency.new(amount - other.amount)
  end
end
