# frozen_string_literal: true

require'station'
require'journey'

class Oystercard
  attr_reader :balance, :history, :journey
  MAX_LIMIT = 90
  MIN_CHARGE = 1
  PENALITY = 6
  def initialize(balance = 0)
    @balance = balance
    @journey = nil
    @history = []
  end

  def top_up(value)
    raise "You exceeded the limit of #{MAX_LIMIT}£" if limit?(value)

    @balance += value
  end

  def touch_in(station)
    raise 'Not Enough Balance' if @balance < MIN_CHARGE

    unless @journey.nil?
      incomplete
      @history << @journey.dup
    end
    @journey = Journey.new
    @journey.start_journey(station)
  end

  def touch_out(station)
    @journey = current_journey
    @journey.finish_journey(station)
    if @journey.complete?
      fare
    else
      incomplete
    end
    @history << @journey.dup
    @journey = nil
  end

  def current_journey
    @journey ||= Journey.new
  end

  def fare
    deduct(MIN_CHARGE)
  end

  def incomplete
    deduct(PENALITY)
  end

  def limit?(value)
    @balance + value >= MAX_LIMIT
  end

  def deduct(value)
    @balance -= value
  end
end
