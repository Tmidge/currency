require 'minitest/autorun'
require 'minitest/pride'
require './currency.rb'
require './different_currency_code_error.rb'

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

  def test_03_can_be_added
    currency = Currency.new("Dollars",100)
    currency1 = Currency.new("Dollars",100)
    currency_added = currency + currency1
    assert_equal 200, currency_added.amount
  end

  def test_04_can_be_subtracted
    currency = Currency.new("Dollars",100)
    currency1 = Currency.new("Dollars",100)
    currency_sum = currency - currency1
    assert_equal 0, currency_sum.amount
  end

  def test_05_no_adding_other_currencies_or_subtracting
    currency = Currency.new("Yen",100)
    currency1 = Currency.new("Dollars",100)
    assert_raises(DifferentCurrencyCodeError) do
      currency + currency1
    end
    assert_raises(DifferentCurrencyCodeError) do
      currency - currency1
    end
  end

  def test_06_multiplication_with_floats_and_fixnums
    currency = Currency.new("Dollars",10)
    assert_equal Currency.new("Dollars", 33), currency * 3.3
  end

end
