# frozen_string_literal: true

require_relative 'schedule'
class Account
  attr_reader :balance
  def initialize(balance = 0)
    @balance = balance
    @schedule = Schedule.new
  end

  def deposit(credit_amount)
    @balance += credit_amount
    @schedule.submit(('%.2f' % credit_amount), nil, ('%.2f' % balance))
  end

  def withdraw(debit_amount)
    @balance -= debit_amount
    @schedule.submit(nil, ('%.2f' % debit_amount), ('%.2f' % balance))
  end

  def statement
    @schedule.statement
  end
end
