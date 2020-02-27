# frozen_string_literal: true

require 'oystercard'
require 'journey'
describe Oystercard do
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }

  it 'check if balance by default is 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it "top up's the balance with the value" do
      expect(subject.top_up(5)).to eq 5
    end

    it 'raises an error when balance is more than 90' do
      error = 'You exceeded the limit of 90£'
      subject.top_up(5)
      expect { subject.top_up(86) }.to raise_error error
    end
  end
  describe '#touch_in' do
    it'No entry station exits before touch in' do
      expect(subject.journey).to eq nil
    end

    it 'raise error when touch in if balance is less than 1£' do
      error = 'Not Enough Balance'
      expect { subject.touch_in(station_name: 'whitechappel', zone: 2) }.to raise_error error
    end

    it 'check it deducts penality when again touch in done without previous trip ended' do
      subject.top_up(10)
      subject.touch_in(station_name: 'whitechappel', zone: 2)
      current_journey = subject.current_journey
      expect { subject.touch_in(station_name: 'xyz', zone: 1) }.to change { subject.balance }.by(-Oystercard::PENALITY)
      expect(subject.history).to include current_journey
    end
  end
  describe '#touch_out' do
    let(:station) { double Station.new('oxford street', 1) }
    let(:other_station) { double Station.new('kings cross', 1) }
    let(:current_journey) { Journey.new }

    before do
      subject.top_up(Oystercard::MIN_CHARGE)
    end
    it 'checks if deducts fare if journey is completed' do
      subject.touch_in(station)
      # current_journey = subject.current_journey
      current_journey.entry_station = station
      current_journey.exit_station = other_station
      expect { subject.touch_out(other_station) }.to change { subject.balance }.by(-Oystercard::MIN_CHARGE)
      expect(subject.history).to include current_journey
    end
    it 'checks if deducts penality while touch out if no touch in was done' do
      current_journey.exit_station = other_station
      expect { subject.touch_out(other_station) }.to change { subject.balance }.by(-Oystercard::PENALITY)
      expect(subject.history).to include current_journey
    end
    it 'maintains history of travel or not' do
    end
    it 'forgets journey when touch out' do
      subject.touch_in(station)
      subject.touch_out(other_station)
      expect(subject.journey).to eq nil
    end
  end
  describe '#deduct' do
    it 'deducts the value from the balance' do
      subject.top_up(10)
      expect(subject.deduct(4)).to eq 6
    end
  end
end
