require './currency.rb'

class CurrencyConverter
  attr_accessor :codes
  def initialize(codes)
    @codes = codes
  end
end
