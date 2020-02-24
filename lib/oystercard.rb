# frozen_string_literal: true

class Oystercard
  attr_reader :balance
  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(value)
    @balance += value
    raise 'You exceeded the limit of 90£' if limit?
    @balance
  end

  def deduct(value)
    @balance -= value
  end

  private

  def limit?
    @balance >= 90
  end
end
