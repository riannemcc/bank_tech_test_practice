# frozen_string_literal: true

require 'account'
require 'timecop'

describe Account do
  it 'starts with an opening balance of 0' do
    account = Account.new
    expect(account.balance).to eq 0
  end

  it 'starts with an empty array of transactions' do
    account = Account.new
    expect(account.transactions).to eq []
  end

  describe 'credit' do
    it 'allows balance to be credited with specified amount' do
      expect { subject.credit(10) }.to change { subject.balance }.by 10
    end
  end

  describe 'debit' do
    it 'allows balance to be debited with specified amount' do
      expect { subject.debit(10) }.to change { subject.balance }.by -10
    end
  end

  describe 'statement' do
    before do
      @time_now = '26/08/2019'
      Timecop.freeze(@time_now)
    end

    it 'returns a credit transaction' do
      account = Account.new
      account.credit(10)
      expect(account.transactions[0]).to eq '26/08/2019 || 10.00 || || 10.00'
    end

    it 'returns a debit transaction' do
      account = Account.new(50)
      account.debit(20)
      expect(account.transactions[0]).to eq '26/08/2019 || || 20.00 || 30.00'
    end

    it 'returns multiple transactions' do
      account = Account.new
      account.credit(100)
      account.debit(20)
      expect(account.transactions).to eq ['26/08/2019 || 100.00 || || 100.00', '26/08/2019 || || 20.00 || 80.00']
    end

    it 'returns multiple transactions with a header' do
      account = Account.new
      account.credit(100)
      account.debit(20)
      expect(account.statement).to eq 'date || credit || debit || balance\n26/08/2019 || 100.00 || || 100.00\n26/08/2019 || || 20.00 || 80.00'
    end
  end
end
