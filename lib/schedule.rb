require_relative 'account'

class Schedule
  attr_reader :transactions, :date
  def initialize
    @transactions = []
    @date = Time.now.strftime('%d/%m/%Y')
  end

  def submit(credit_amount = nil, debit_amount = nil, balance)
    @transactions << "#{@date} || |#{credit_amount}| |#{debit_amount}| || #{balance}"
  end

  def statement
    @transactions.unshift('Date || Credit || Debit|| Balance ||')
    @transactions.each { |transaction|
      puts transaction }
  end
end
