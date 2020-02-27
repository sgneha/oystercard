# frozen_string_literal: true

require 'station'
describe Station do
  subject { described_class.new('oxford street', 1) }
  it 'it knows its name' do
    expect(subject.station_name).to eq 'oxford street'
  end
  it 'it knows its zone' do
    expect(subject.zone).to eq 1
  end
end
