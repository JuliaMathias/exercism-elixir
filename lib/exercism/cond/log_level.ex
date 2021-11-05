defmodule Exercism.Cond.LogLevel do
  @moduledoc """
  You are running a system that consist of a few applications producing many logs. You want to write a small program that will aggregate those logs and give them labels according to their severity level. All applications in your system use the same log codes, but some of the legacy applications don't support all the codes.
  """

  @spec to_label(integer, boolean) :: atom
  def to_label(level, legacy?) do
    cond do
      level == 0 && legacy? == true -> :unknown
      level == 0 -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 && legacy? == true -> :unknown
      level == 5 -> :fatal
      true -> :unknown
    end
  end

  @spec alert_recipient(integer, boolean) :: :dev1 | :dev2 | false | :ops
  def alert_recipient(level, legacy?) do
    cond do
      to_label(level, legacy?) == :error || to_label(level, legacy?) == :fatal -> :ops
      to_label(level, legacy?) == :unknown && legacy? == true -> :dev1
      to_label(level, legacy?) == :unknown && legacy? == false -> :dev2
      true -> false
    end
  end
end
