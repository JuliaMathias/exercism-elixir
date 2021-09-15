defmodule Exercism.Guards.TwoFer do
  @moduledoc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.

  Given a name, return a string with the message:

  One for name, one for me.
  Where "name" is the given name.

  However, if the name is missing, return the string:

  One for you, one for me.
  Here are some examples:

  Name	  String to return
  Alice	  One for Alice, one for me.
  Bob	    One for Bob, one for me.
          One for you, one for me.
  Zaphod  One for Zaphod, one for me.

  """
  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.

  ## Examples
    iex> TwoFer.two_fer()
    "One for you, one for me."
    iex> TwoFer.two_fer("Julia")
    "One for Julia, one for me."
  """
  @spec two_fer(String.t()) :: String.t()
  def two_fer(name \\ "you") when is_binary(name) do
    "One for #{name}, one for me."
  end
end
