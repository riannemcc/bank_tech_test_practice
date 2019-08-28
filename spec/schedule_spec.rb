# frozen_string_literal: true

require 'schedule'
require 'account'
require 'timecop'

describe Schedule do

  it 'starts with an empty array of transactions' do
    transactions = Schedule.new
    expect(transactions.transactions).to eq []
  end
end

describe 'statement' do
  before do
    @time_now = '26/08/2019'
    Timecop.freeze(@time_now)
    account
  end

  it 'returns a credit transaction' do
    transactions = Schedule.new
    transactions.submit(10, nil, 10)
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
