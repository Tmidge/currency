require './currency.rb'

class CurrencyConverter
  attr_accessor :codes
  def initialize(codes)
    @codes = codes
  end

  def convert(currency, new_code)
    if currency.code == new_code
      return currency
    end
  end
end
