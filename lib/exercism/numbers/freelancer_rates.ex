defmodule Exercism.Numbers.FreelancerRates do
  @spec daily_rate(number) :: float
  def daily_rate(hourly_rate), do: hourly_rate * 8.0

  @spec apply_discount(number, number) :: float
  def apply_discount(before_discount, discount), do: before_discount * ((100 - discount) / 100)

  @spec monthly_rate(number, number) :: integer
  def monthly_rate(hourly_rate, discount) do
    monthly_rate_before_discount = daily_rate(hourly_rate) * 22

    apply_discount(monthly_rate_before_discount, discount)
    |> Float.ceil()
    |> Kernel.trunc()
  end

  @spec days_in_budget(number, number, number) :: float
  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate_before_discount = daily_rate(hourly_rate)
    discounted_daily_rate = apply_discount(daily_rate_before_discount, discount)

    (budget / discounted_daily_rate)
    |> Float.floor(1)
  end
end
