defmodule Exercism.Recursion.DNA do
  @moduledoc """
  In your DNA research lab, you have been working through various ways to compress your research data to save storage space. One teammate suggests converting the DNA data to a binary representation:

  Nucleic Acid	Code
  a space	      0000
  A	            0001
  C	            0010
  G	            0100
  T	            1000

  You ponder this, as it will potentially halve the required data storage costs, but at the expense of human readability. You decide to write a module to encode and decode your data to benchmark your savings.
  """

  @spec encode_nucleotide(32 | 65 | 67 | 71 | 84) :: 0 | 1 | 2 | 4 | 8
  @doc """
  Implement encode_nucleotide/1 to accept the code point for the nucleic acid and return the integer value of the encoded code.

  ### Example

  iex> DNA.encode_nucleotide(?A)
  0b0001
  """
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  @spec decode_nucleotide(0 | 1 | 2 | 4 | 8) :: 32 | 65 | 67 | 71 | 84
  @doc """
  Implement decode_nucleotide/1 to accept the integer value of the encoded code and return the code point for the nucleic acid.

  ### Example

  DNA.decode_nucleotide(0b0001)
  iex> ?A

  """
  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  @spec encode([32 | 65 | 67 | 71 | 84]) :: bitstring
  @doc """
  Implement encode/1 to accept a charlist representing nucleic acids and gaps and return a bitstring of the encoded data.

  ### Example

  DNA.encode('AC GT')
  iex> <<18, 4, 8::size(4)>>

  """
  def encode(dna), do: do_encode(dna, <<0::size(0)>>)

  defp do_encode([], result), do: result

  defp do_encode([head | tail], result) do
    do_encode(tail, <<result::bitstring, encode_nucleotide(head)::4>>)
  end

  @spec decode(bitstring) :: [32 | 65 | 67 | 71 | 84]
  @doc """
  Implement decode/1 to accept a bitstring representing nucleic acids and gaps and return the decoded data as a charlist.

  ### Example

  DNA.decode(<<132, 2, 1::size(4)>>)
  iex> 'TG CA'

  """
  def decode(dna), do: do_decode(dna, '')

  defp do_decode(<<0::0>>, result), do: result

  defp do_decode(<<head::4, rest::bitstring>>, result) do
    do_decode(rest, result ++ [decode_nucleotide(head)])
  end
end
