defmodule Exercism.Booleans.Bob do
  @moduledoc """
  Bob is a lackadaisical teenager. In conversation, his responses are very limited.

  Bob answers 'Sure.' if you ask him a question, such as "How are you?".

  He answers 'Whoa, chill out!' if you YELL AT HIM (in all capitals).

  He answers 'Calm down, I know what I'm doing!' if you yell a question at him.

  He says 'Fine. Be that way!' if you address him without actually saying anything.

  He answers 'Whatever.' to anything else.

  Bob's conversational partner is a purist when it comes to written communication and always follows normal rules regarding sentence punctuation in English.
  """

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)

    cond do
      String.match?(input, ~r/^[0-9]*[A-Za-z]{0,1}[^A-Z]+.*\?\s*$/) ->
        "Sure."

      input == "" ->
        "Fine. Be that way!"

      String.match?(input, ~r/^[^a-z]*\?\s*$/) ->
        "Calm down, I know what I'm doing!"

      String.match?(input, ~r/^[0-9,\s]*.[^a-z]+.[^a-z\s]+[^?]$/) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end
end
