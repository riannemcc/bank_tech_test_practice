require_relative 'account'

class Schedule
  attr_reader :transactions, :date
  def initialize
    @transactions = []
  end

  def submit(credit_amount = nil, debit_amount = nil, balance)
    @date = Time.now.strftime('%d/%m/%Y')
    @transactions << "#{date} || |#{credit_amount}| |#{debit_amount}| || #{balance}"
  end

  def statement
    "date || credit || debit || balance\\n" + @transactions.join("\\n")
  end
end
