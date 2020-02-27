# frozen_string_literal: true

require 'journey'
describe Journey do
  let(:station) { double :station }
  it 'knows if a journey is not complete' do
    expect(subject).not_to be_complete
  end
  it 'returns itself when exiting a journey' do
    expect(subject.finish_journey(station)).to eq station
  end
  context 'entry station' do
    # subject { described_class.new }
    it 'has no entry station' do
      expect(subject.entry_station). to eq nil
    end
    it 'when journey starts it has entry station' do
      expect(subject.start_journey(station)).to eq station
    end
    it 'checks if the journey is complete' do
      expect(subject.complete?).to eq false
    end
  end
  context 'exit station' do
    let(:other_station) { double :other_station }
    before do
      subject.start_journey(station)
      subject.finish_journey(other_station)
    end

    it 'checks if the journey is complete' do
      expect(subject.complete?).to eq true
    end
  end
end
