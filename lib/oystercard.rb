# frozen_string_literal: true

class Oystercard
  attr_reader :balance
  attr_accessor :state
  LIMIT = 90
  def initialize(balance = 0, state = false)
    @balance = balance
    @state = state
  end

  def top_up(value)
    @balance += value
    raise 'You exceeded the limit of 90£' if limit?
    @balance
  end

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    @state
  end

  def touch_in
    raise 'Not Enough Balance' if @balance < 1
    @state = true
  end

  def touch_out
    @state = false
  end

  private

  def limit?
    @balance >= LIMIT
  end
end
