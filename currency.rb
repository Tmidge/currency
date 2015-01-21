require './different_currency_code_error.rb'

class Currency
  attr_accessor :code, :amount
  def initialize(code, amount = 1)
    @symbols_for_code = {"$"=> :USD, "€"=> :EUR, "¥"=> :JPY}
    if code.class == String
      @code = @symbols_for_code[code[0]]
      @amount = code.gsub(code[0],"").to_f
    else
      @code = code
      @amount = amount
    end
  end

  def +(other)
    if @code == other.code
      Currency.new(@code, @amount + other.amount)
    else
      raise DifferentCurrencyCodeError, "Don't do that."
    end
  end

  def ==(other)
    @amount == other.amount
  end

  def -(other)
    if @code == other.code
      Currency.new(@code, @amount - other.amount)
    else
      raise DifferentCurrencyCodeError, "Don't do that."
    end
  end

  def *(nums)
    Currency.new(@code, @amount * nums)
  end
  def /(nums)
    Currency.new(@code, @amount / nums)
  end

end
