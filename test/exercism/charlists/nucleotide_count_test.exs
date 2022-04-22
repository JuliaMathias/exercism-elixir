defmodule Exercism.Charlists.NucleotideCountTest do
  use ExUnit.Case
  alias Exercism.Charlists.NucleotideCount
  doctest Exercism.Charlists.NucleotideCount

  describe "count" do
    test "empty dna string has no adenine" do
      assert NucleotideCount.count('', ?A) == 0
    end

    test "one nucleotide" do
      assert NucleotideCount.count('G', ?G) == 1
    end

    test "repetitive cytosine gets counted" do
      assert NucleotideCount.count('CCCCC', ?C) == 5
    end

    test "counts only thymine" do
      assert NucleotideCount.count('GGGGGTAACCCGG', ?T) == 1
    end
  end

  describe "histogram" do
    test "empty dna string has no nucleotides" do
      expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
      assert NucleotideCount.histogram('') == expected
    end

    test "one nucleotide" do
      expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 1}
      assert NucleotideCount.histogram('G') == expected
    end

    test "repetitive sequence has only guanine" do
      expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 8}
      assert NucleotideCount.histogram('GGGGGGGG') == expected
    end

    test "counts all nucleotides" do
      s = 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'
      expected = %{?A => 20, ?T => 21, ?C => 12, ?G => 17}
      assert NucleotideCount.histogram(s) == expected
    end
  end
end