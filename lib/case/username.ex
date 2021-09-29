defmodule Exercism.Case.Username do
  @moduledoc """
  You are working as a system administrator for a big company in Munich, Germany. One of your responsibilities is managing email accounts.

  You have been hearing complaints from people saying they are unable to write emails to Mr. Müller. You quickly realize that most of the company uses an old email client that doesn't recognize müller@firma.de as a valid email address because of the non-Latin character.

  Telling people to give up their favorite old email client is a lost battle, so you decide to create sanitized aliases for all email accounts.
  """

  @doc """
  Implement the sanitize/1 function. It should accept a username as a charlist and return the username with all characters but lowercase letters removed.

  Extend the sanitize/1 function. It should not remove underscores from the username.



  ## Examples
    iex> Username.sanitize('schmidt1985')
    'schmidt'
    iex> Username.sanitize('mark_fischer$$$')
    'mark_fischer'
    iex> Username.sanitize('cäcilie_weiß')
    'caecilie_weiss'
  """
  @spec sanitize(charlist) :: charlist
  def sanitize(username), do: username |> do_sanitize([])

  defp do_sanitize([], acc) do
    Enum.reverse(acc)
  end

  defp do_sanitize([head | tail], acc) do
    case head do
      head when head in 97..122 -> do_sanitize(tail, [head | acc])
      95 -> do_sanitize(tail, [head | acc])
      223 -> do_sanitize(tail, [115, 115 | acc])
      228 -> do_sanitize(tail, [101, 97 | acc])
      246 -> do_sanitize(tail, [101, 111 | acc])
      252 -> do_sanitize(tail, [101, 117 | acc])
      _ -> do_sanitize(tail, acc)
    end
  end
end
