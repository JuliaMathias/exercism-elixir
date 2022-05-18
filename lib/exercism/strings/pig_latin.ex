defmodule Exercism.Strings.PigLatin do
  @moduledoc """
  Implement a program that translates from English to Pig Latin.

  Pig Latin is a made-up children's language that's intended to be confusing. It obeys a few simple rules (below), but when it's spoken quickly it's really difficult for non-children (and non-native speakers) to understand.

  - *Rule 1:* If a word begins with a vowel sound, add an "ay" sound to the end of the word. Please note that "xr" and "yt" at the beginning of a word make vowel sounds (e.g. "xray" -> "xrayay", "yttria" -> "yttriaay").

  - *Rule 2:* If a word begins with a consonant sound, move it to the end of the word and then add an "ay" sound to the end of the word. Consonant sounds can be made up of multiple consonants, a.k.a. a consonant cluster (e.g. "chair" -> "airchay").

  - *Rule 3:* If a word starts with a consonant sound followed by "qu", move it to the end of the word, and then add an "ay" sound to the end of the word (e.g. "square" -> "aresquay").

  - *Rule 4:* If a word contains a "y" after a consonant cluster or as the second letter in a two letter word it makes a vowel sound (e.g. "rhythm" -> "ythmrhay", "my" -> "ymay").
  There are a few more rules for edge cases, and there are regional variants too.

  See http://en.wikipedia.org/wiki/Pig_latin for more details.
  """

  @vowels ["a", "e", "i", "o", "u"]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(<<first_letter::binary-size(1), second_letter::binary-size(1)>>)
       when second_letter == "y",
       do: second_letter <> first_letter <> "ay"

  defp translate_word(
         <<first_letter::binary-size(1), second_letter::binary-size(1),
           third_letter::binary-size(1), rest::binary>>
       )
       when third_letter == "y" and (first_letter not in @vowels and second_letter not in @vowels),
       do: third_letter <> rest <> first_letter <> second_letter <> "ay"

  defp translate_word(
         <<first_letter::binary-size(1), second_letter::binary-size(1), _rest::binary>> = phrase
       )
       when first_letter in @vowels or
              ((first_letter == "x" or first_letter == "y") and second_letter not in @vowels),
       do: phrase <> "ay"

  defp translate_word(
         <<first_letter::binary-size(1), second_letters::binary-size(2), rest::binary>>
       )
       when second_letters == "qu",
       do: rest <> first_letter <> second_letters <> "ay"

  defp translate_word(<<first_letters::binary-size(2), rest::binary>>)
       when first_letters == "qu",
       do: rest <> first_letters <> "ay"

  defp translate_word(phrase), do: consonant_words(String.split(phrase, ""))

  defp consonant_words([h | t]), do: consonant_words(t, h)

  defp consonant_words([h | t], consonant_cluster) when h not in @vowels,
    do: consonant_words(t, consonant_cluster <> h)

  defp consonant_words(rest, consonant_cluster),
    do: List.to_string(rest) <> consonant_cluster <> "ay"
end
