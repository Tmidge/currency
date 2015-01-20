require 'minitest/autorun'
require 'minitest/pride'
require './currency.rb'

class CurrencyTest < Minitest::Test

  def test_00_ship_class_exists
    assert Currency
  end

end
