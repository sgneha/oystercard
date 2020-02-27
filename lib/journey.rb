# frozen_string_literal: true
require'station'

class Journey
  attr_accessor :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(station)
    @entry_station = station
  end

  def finish_journey(station)
    @exit_station = station
  end

  def complete?
    !@entry_station.nil? && !@exit_station.nil?
  end

  def ==(other)
    entry_station == other.entry_station &&
      exit_station == other.exit_station
  end
end
