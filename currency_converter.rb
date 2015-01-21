require './currency.rb'

class CurrencyConverter
  attr_accessor :codes
  def initialize(codes)
    @codes = codes
  end

  def convert(currency, new_code)
    if currency.code == new_code

      return currency

    else
      new_amount = currency.amount*codes[new_code]
      return Currency.new(new_code , new_amount)
    end
  end
end
