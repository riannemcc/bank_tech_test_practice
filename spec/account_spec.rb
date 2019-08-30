# frozen_string_literal: true

require 'account'
require 'timecop'

describe Account do

  let(:schedule){ double :schedule}
  it 'starts with an opening balance of 0' do
    account = Account.new
    expect(subject.balance).to eq 0
  end

  describe 'deposit' do
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
    end

    it 'returns the schedule statement' do
    allow(schedule).to receive(:statement).and_return("date || credit || debit || balance\\n26/08/2019 || |100.00| || || 100.00\\n26/08/2019 || || |10.00| || 90.00")
    subject = Account.new
    subject.deposit(100)
    subject.withdraw(10)
    schedule.statement
    expect(subject.statement).to eq "date || credit || debit || balance\\n26/08/2019 || |100.00| || || 100.00\\n26/08/2019 || || |10.00| || 90.00"
  end

    it 'returns multiple transactions with a header' do
      account = Account.new
      account.deposit(100)
      account.withdraw(20)
      expect(account.statement).to eq 'date || credit || debit || balance\n26/08/2019 || |100.00| || || 100.00\n26/08/2019 || || |20.00| || 80.00'
    end
end
end
