defmodule Exercism.BitManipulation.SecretHandshake do
  @moduledoc """

  > *There are 10 types of people in the world: Those who understand binary, and those who don't.*

  You and your fellow cohort of those in the "know" when it comes to binary decide to come up with a secret "handshake".

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump


  10000 = Reverse the order of the operations in the secret handshake.

  Given a decimal number, convert it to the appropriate sequence of events for a secret handshake.

  Here's a couple of examples:

  Given the input 3, the function would return the array ["wink", "double blink"] because 3 is 11 in binary.

  Given the input 19, the function would return the array ["double blink", "wink"] because 19 is 10011 in binary. Notice that the addition of 16 (10000 in binary) has caused the array to be reversed.

  """
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
    |> Integer.to_string(2)
    |> check_last_digit()
    |> check_second_digit()
    |> check_third_digit()
    |> check_fourth_digit()
    |> check_fifth_digit()
    |> elem(1)
  end

  defp check_last_digit(binary_code) do
    if String.last(binary_code) == "1", do: {binary_code, ["wink"]}, else: {binary_code, []}
  end

  defp check_second_digit({binary_code, command_list}) do
    if String.slice(binary_code, -2..-2) == "1",
      do: {binary_code, command_list ++ ["double blink"]},
      else: {binary_code, command_list}
  end

  defp check_third_digit({binary_code, command_list}) do
    if String.slice(binary_code, -3..-3) == "1",
      do: {binary_code, command_list ++ ["close your eyes"]},
      else: {binary_code, command_list}
  end

  defp check_fourth_digit({binary_code, command_list}) do
    if String.slice(binary_code, -4..-4) == "1",
      do: {binary_code, command_list ++ ["jump"]},
      else: {binary_code, command_list}
  end

  defp check_fifth_digit({binary_code, command_list}) do
    if String.slice(binary_code, -5..-5) == "1",
      do: {binary_code, Enum.reverse(command_list)},
      else: {binary_code, command_list}
  end
end
