defmodule Exercism.Recursion.MatchingBrackets do
  @moduledoc """
  Given a string containing brackets `[]`, braces `{}`, parentheses `()`, or any combination thereof, verify that any and all pairs are matched and nested correctly.
  """

  @start ["[", "{", "("]
  @ending ["]", "}", ")"]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    IO.inspect(binding(),
      label: "binding() #{__MODULE__}:#{__ENV__.line} #{DateTime.utc_now()}",
      limit: :infinity
    )

    str
    |> String.split("", trim: true)
    |> capture_start(%{string: str, start: [], end: []})
  end

  defp capture_start([h | t], %{start: start} = map) when h in @start do
    IO.inspect(binding(),
      label: "binding() #{__MODULE__}:#{__ENV__.line} #{DateTime.utc_now()}",
      limit: :infinity
    )

    new_start = start ++ [h]

    capture_start(t, Map.replace!(map, :start, new_start))
  end

  defp capture_start([_h | t], map), do: capture_start(t, map)

  defp capture_start([], %{string: string} = map),
    do: capture_end(String.split(string, "", trim: true), map)

  defp capture_end([h | t], %{end: ending} = map) when h in @ending do
    IO.inspect(binding(),
      label: "binding() #{__MODULE__}:#{__ENV__.line} #{DateTime.utc_now()}",
      limit: :infinity
    )

    new_end = ending ++ [h]

    capture_end(t, Map.replace!(map, :end, new_end))
  end

  defp capture_end([_h | t], map), do: capture_end(t, map)

  defp capture_end([], map), do: check_match(Map.replace!(map, :end, Enum.reverse(map.end)))

  defp check_match(%{string: string, start: [start_head | start_tail], end: [end_head | end_tail]})
       when start_head == "{" and end_head == "}" do
    IO.inspect(binding(),
      label: "binding() #{__MODULE__}:#{__ENV__.line} #{DateTime.utc_now()}",
      limit: :infinity
    )

    check_match(%{string: string, start: start_tail, end: end_tail})
  end

  defp check_match(%{string: string, start: [start_head | start_tail], end: [end_head | end_tail]})
       when start_head == "[" and end_head == "]" do
    IO.inspect(binding(),
      label: "binding() #{__MODULE__}:#{__ENV__.line} #{DateTime.utc_now()}",
      limit: :infinity
    )

    check_match(%{string: string, start: start_tail, end: end_tail})
  end

  defp check_match(%{string: string, start: [start_head | start_tail], end: [end_head | end_tail]})
       when start_head == "(" and end_head == ")" do
    check_match(%{string: string, start: start_tail, end: end_tail})
  end

  defp check_match(%{start: [], end: []}), do: true

  defp check_match(_), do: false

  # defp check_match(%{string: string, start: [start_head | start_tail], end: [end_head | end_tail]}) do
  #   IO.inspect(binding(),
  #     label: "binding() #{__MODULE__}:#{__ENV__.line} #{DateTime.utc_now()}",
  #     limit: :infinity
  #   )

  #   false
  # end
end
