class Currency
  attr_accessor :code, :amount
  def initialize(code, amount)
    @code = code
    @amount = amount
  end
end
