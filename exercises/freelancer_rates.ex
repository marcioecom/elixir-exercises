defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    discount = before_discount / 100 * discount
    before_discount - discount
  end

  def monthly_rate(hourly_rate, discount) do
    without_discount = daily_rate(hourly_rate) * 22
    result = apply_discount(without_discount, discount)
    ceil(result)
  end

  def days_in_budget(budget, hourly_rate, discount) do
    without_discount = daily_rate(hourly_rate)
    rate_with_discount = ceil(apply_discount(without_discount, discount))
    result = budget / rate_with_discount
    Float.floor(result, 1)
  end
end
