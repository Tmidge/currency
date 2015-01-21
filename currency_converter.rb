require './currency.rb'

class CurrencyConverter
  attr_accessor :codes
  def initialize(codes)
    @codes = codes
  end

  def convert(currency, new_code)
    if @codes.include?(new_code) == false
      raise UnknownCurrencyCodeError, "Don't do that."
    elsif currency.code == new_code

      return currency

    elsif currency.amount > codes[new_code]
      new_amount = currency.amount*codes[new_code]
      return Currency.new(new_code , new_amount)
    elsif currency.amount < codes[new_code]
      new_amount = codes[new_code]/codes[currency.code]
      return Currency.new(new_code , new_amount)
    end
  end
end
