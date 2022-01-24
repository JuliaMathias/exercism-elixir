defmodule Exercism.Regex.RunLengthEncoder do
  @moduledoc """
  Implement run-length encoding and decoding.

  Run-length encoding (RLE) is a simple form of data compression, where runs (consecutive data elements) are replaced by just one data value and count.

  For example we can represent the original 53 characters with only 13.
  ```
  "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"  ->  "12WB12W3B24WB"
  ```

  RLE allows the original data to be perfectly reconstructed from the compressed data, which makes it a lossless data compression.

  ```
  "AABCCCDEEEE"  ->  "2AB3CD4E"  ->  "AABCCCDEEEE"
  ```

  For simplicity, you can assume that the unencoded string will only contain the letters A through Z (either lower or upper case) and whitespace. This way data to be encoded will never contain any numbers and numbers inside data to be decoded always represent the count for the following character.
  """

  @numbers ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    ~r/([\w\s])\1*/
    |> Regex.scan(string)
    |> Enum.map(fn [capture, char] -> maybe_return_quantity(capture) <> char end)
    |> Enum.join("")
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.split(~r{\d*(\w|\s)}, string, trim: true, include_captures: true)
    |> Enum.map(fn string_piece -> maybe_multiply_character(string_piece) end)
    |> Enum.join("")
  end

  defp maybe_return_quantity(capture) do
    if String.length(capture) > 1, do: to_string(String.length(capture)), else: ""
  end

  defp maybe_multiply_character(string_piece) do
    if String.contains?(string_piece, @numbers) do
      case String.length(string_piece) do
        1 ->
          string_piece

        2 ->
          [multiplier, character] = String.split(string_piece, "", trim: true)
          String.duplicate(character, String.to_integer(multiplier))

        3 ->
          {multiplier, character} = String.split_at(string_piece, 2)
          String.duplicate(character, String.to_integer(multiplier))
      end
    else
      string_piece
    end
  end
end
