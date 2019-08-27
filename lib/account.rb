# frozen_string_literal: true

class Account
  attr_reader :balance, :transactions, :date
  def initialize(balance = 0)
    @balance = balance
    @transactions = []
    @date = Time.now
  end

  def credit(amount)
    @balance += amount
    @transactions << "#{@date.strftime('%d/%m/%Y')} || #{'%.2f' % amount} || || #{'%.2f' % @balance}"
  end

  def debit(amount)
    @balance -= amount
    @transactions << "#{@date.strftime('%d/%m/%Y')} || || #{'%.2f' % amount} || #{'%.2f' % @balance}"
  end

  def statement
    "date || credit || debit || balance\\n" + @transactions.join("\\n")
  end
end
