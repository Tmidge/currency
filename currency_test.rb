require 'minitest/autorun'
require 'minitest/pride'
require './currency.rb'
require './different_currency_code_error.rb'
require './currency_converter.rb'
require './unknown_currency_code_error.rb'


class CurrencyTest < Minitest::Test

  def test_00_currency_class_exists
    assert Currency
  end

  def test_01_created_with_code_and_amount
    currency = Currency.new(:USD,100)
    assert_equal :USD, currency.code
    assert_equal 100, currency.amount
  end

  def test_02_equal_to_currency_with_the_same_code_and_amount
    currency = Currency.new(:USD,100)
    currency1 = Currency.new(:USD,100)
    assert currency == currency1
  end

  def test_03_can_be_added
    currency = Currency.new(:USD,100)
    currency1 = Currency.new(:USD,100)
    currency_added = currency + currency1
    assert_equal 200, currency_added.amount
  end

  def test_04_can_be_subtracted
    currency = Currency.new(:USD,100)
    currency1 = Currency.new(:USD,100)
    currency_sum = currency - currency1
    assert_equal 0, currency_sum.amount
  end

  def test_05_no_adding_other_currencies_or_subtracting
    currency = Currency.new(:JPY,100)
    currency1 = Currency.new(:USD,100)
    assert_raises(DifferentCurrencyCodeError) do
      currency + currency1
    end
    assert_raises(DifferentCurrencyCodeError) do
      currency - currency1
    end
  end

  def test_06_multiplication_with_floats_and_fixnums
    currency = Currency.new(:USD,10)
    assert_equal Currency.new(:USD, 33), currency * 3.3
  end

  #CurrencyConverter:
  #
  #Should be initialized with a Hash of currency codes to conversion rates (see link to rates below)
  #At first, just make this work with two currency codes and conversation rates, with one rate being 1.0 and the other being the conversation rate. An example would be this: {USD: 1.0, EUR: 0.74}, which implies that a dollar is worth 0.74 euros.
  #Should be able to take a Currency object and a requested currency code that is the same currency code as the Currency object's and return a Currency object equal to the one passed in (that is, currency_converter.convert(Currency.new(1, :USD), :USD) == Currency.new(1, :USD))
  #Should be able to take a Currency object that has one currency code it knows and a requested currency code and return a new Currency object with the right amount in the new currency code
  #Should be able to be created with a Hash of three or more currency codes and conversion rates. An example would be this: {USD: 1.0, EUR: 0.74, JPY: 120.0}, which implies that a dollar is worth 0.74 euros and that a dollar is worth 120 yen, but also that a euro is worth 120/0.74 = 162.2 yen.
  #Should be able to convert Currency in any currency code it knows about to Currency in any other currency code it knows about.
  #Should raise an UnknownCurrencyCodeError when you try to convert from or to a currency code it doesn't know about.
  #Currency (modifications to earlier code):
  #
  #Currency.new should be able to take one argument with a currency symbol embedded in it, like "$1.20" or "€ 7.00", and figure out the correct currency code. It can also take two arguments like before, one being the amount and the other being the currency code.

  #USD
  #EUR
  #GBP
  #INR
  #AUD
  #CAD
  #ZAR
  #NZ
  #JPY
  #1 USD
  #1.00000
  #0.86429	0.66186	61.5600	1.23583	1.23663	11.5544	1.32034	118.026

  #[{:USD => :1,:EUR => :0.86}]

  def test_07_currency_converter_exists
    assert CurrencyConverter
  end

  def test_08_initialized_with_hash_of_codes_and_conversions
    new_currency = CurrencyConverter.new({USD: 1, EUR: 0.86})
    assert_equal ({USD: 1, EUR: 0.86}), new_currency.codes
  end

  def test_09_converting_same_currency_code
    currency_converter = CurrencyConverter.new({USD: 1, EUR: 0.86})
    assert_equal Currency.new(:USD, 1), currency_converter.convert(Currency.new(:USD, 1), :USD)
  end

  def test_10_converting_to_new_code
    currency_converter = CurrencyConverter.new({USD: 1, EUR: 0.86})
    assert_equal Currency.new(:EUR, 0.86), currency_converter.convert(Currency.new(:USD, 1), :EUR)
  end

  def test_11_converting_between_3_codes
    currency_converter = CurrencyConverter.new({USD: 1, EUR: 0.86, JPY: 118.02})
    assert_equal Currency.new(:JPY, 118.02), currency_converter.convert(Currency.new(:USD, 1), :JPY)
    assert_in_delta 137.21, currency_converter.convert(Currency.new(:EUR, 1), :JPY).amount, 0.025
  end
  #Should raise an UnknownCurrencyCodeError when you try to convert from or to a currency code it doesn't know about.
  def test_12_no_converting_currencies_not_in_hash
    currency_converter = CurrencyConverter.new({USD: 1, EUR: 0.86, JPY: 118.02})
    assert_raises(UnknownCurrencyCodeError) do
      currency_converter.convert(Currency.new(:USD, 1), :XYR)
    end
  end
end
