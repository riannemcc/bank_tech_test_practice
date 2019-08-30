# frozen_string_literal: true

require 'schedule'
require 'account'
require 'timecop'

describe Schedule do

  let(:account){ double :account }
  let(:credit_amount) { double :credit_amount}
  it 'starts with an empty array of transactions' do
    schedule = Schedule.new
    expect(schedule.transactions).to eq []
  end

describe 'statement' do
  before do
    @time_now = '26/08/2019'
    Timecop.freeze(@time_now)
  end

  it 'returns a credit transaction' do
    schedule = Schedule.new
    schedule.submit('%.2f' % 10, nil,'%.2f' %  10)
    expect(schedule.transactions[0]).to eq '26/08/2019 || |10.00| || || 10.00'
  end
end

end
