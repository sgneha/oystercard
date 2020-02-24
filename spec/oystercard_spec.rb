# frozen_string_literal: true

require 'oystercard'
describe Oystercard do
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }
  it 'check if balance by default is 0' do
    expect(subject.balance).to eq 0
  end

  it 'checks the status of the card' do
    expect(subject.in_journey?).to eq false
  end

  describe '#top_up' do
    it "top up's the balance with the value" do
      expect(subject.top_up(5)).to eq 5
    end

    it 'raises an error when balance is more than 90' do
      error = 'You exceeded the limit of 90£'
      expect { subject.top_up(95) }.to raise_error error
    end
  end
  describe '#deduct' do
    it 'deducts the value from the balance' do
      subject.top_up(10)
      expect(subject.deduct(4)).to eq 6
    end
  end
end
