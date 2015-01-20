require 'minitest/autorun'
require 'minitest/pride'
require './currency.rb'

 #Should be created with an amount and a currency code
 #Should equal another Currency object with the same amount and currency code
 #Should be able to be added to another Currency object with the same currency code
 #Should be able to be subtracted by another Currency object with the same currency code
 #Should raise a DifferentCurrencyCodeError when you try to add or subtract two Currency objects with different currency codes.
 #Should be able to be multiplied by a Fixnum or Float and return a Currency object

class CurrencyTest < Minitest::Test

  def test_00_currency_class_exists
    assert Currency
  end

  def test_01_created_with_code_and_amount
    currency = Currency.new("Dollars",100)
    assert_equal "Dollars", currency.code
    assert_equal 100, currency.amount
  end

  def test_02_equal_to_currency_with_the_same_code_and_amount
    currency = Currency.new("Dollars",100)
    currency1 = Currency.new("Dollars",100)
    assert currency == currency1
  end

end
