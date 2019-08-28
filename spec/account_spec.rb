# frozen_string_literal: true

require 'account'
require 'timecop'

describe Account do
  it 'starts with an opening balance of 0' do
    account = Account.new
    expect(account.balance).to eq 0
  end

  describe 'credit_balance' do
    it 'allows balance to be credited with specified amount' do
      expect { subject.deposit(10) }.to change { subject.balance }.by 10
    end
  end

  describe 'debit_balance' do
    it 'allows balance to be debited with specified amount' do
      expect { subject.withdraw(10) }.to change { subject.balance }.by -10
    end
  end

  describe 'statement' do
    before do
      @time_now = '26/08/2019'
      Timecop.freeze(@time_now)
      account = Account.new
    end

    it 'returns a credit transaction' do
      account.deposit(100)
      expect(transactions.transactions[0]).to eq '26/08/2019 || 10.00 || || 10.00'
    end

    it 'returns a debit transaction' do
      transactions = Schedule.new
      transactions.submit(nil, 20, 50)
      expect(transactions.transactions[0]).to eq '26/08/2019 || || 20.00 || 30.00'
    end

    it 'returns multiple transactions' do
      transactions = Schedule.new
      transactions.submit(100, 0, 0)
      transactions.submit(0, 20, 100)
      expect(transactions.transactions).to eq ['26/08/2019 || 100.00 || || 100.00', '26/08/2019 || || 20.00 || 80.00']
    end

    it 'returns multiple transactions with a header' do
      transactions = Schedule.new
      transactions.submit(100, 0, 0)
      transactions.submit(0, 20, 100)
      expect(transactions.transactions).to eq 'date || credit || debit || balance\n26/08/2019 || 100.00 || || 100.00\n26/08/2019 || || 20.00 || 80.00'
    end

end
