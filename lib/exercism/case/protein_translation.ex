defmodule Exercism.Case.ProteinTranslation do
  @moduledoc """
  Translate RNA sequences into proteins.

  RNA can be broken into three nucleotide sequences called codons, and then translated to a polypeptide like so:

  RNA: ;`"AUGUUUUCU"` => translates to

  Codons: `"AUG", "UUU", "UCU"` => which become a polypeptide with the following sequence =>

  Protein: `"Methionine", "Phenylalanine", "Serine"`

  There are 64 codons which in turn correspond to 20 amino acids; however, all of the codon sequences and resulting amino acids are not important in this exercise. If it works for one codon, the program should work for all of them. However, feel free to expand the list in the test suite to include them all.

  There are also three terminating codons (also known as 'STOP' codons); if any of these codons are encountered (by the ribosome), all translation ends and the protein is terminated.

  All subsequent codons after are ignored, like this:

  RNA: `"AUGUUUUCUUAAAUG"` =>

  Codons: `"AUG", "UUU", "UCU", "UAA", "AUG"` =>

  Protein: `"Methionine", "Phenylalanine", "Serine"`

  Note the stop codon `"UAA"` terminates the translation and the final methionine is not translated into the protein sequence.

  Below are the codons and resulting Amino Acids needed for the exercise.

  | Codon              |	Protein      |
  | ------------------ | ------------- |
  | AUG                | Methionine    |
  | UUU, UUC	         | Phenylalanine |
  | UUA, UUG           | Leucine       |
  | UCU, UCC, UCA, UCG | Serine        |
  | UAU, UAC	         | Tyrosine      |
  | UGU, UGC	         | Cysteine      |
  | UGG	               | Tryptophan    |
  | UAA, UAG, UGA	     | STOP          |
  """

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    codon_list = for <<codon::binary-3 <- rna>>, do: of_codon(codon)

    if Enum.member?(codon_list, {:error, "invalid codon"}) do
      {:error, "invalid RNA"}
    else
      {:ok, decode_rna(codon_list)}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case codon do
      "AUG" ->
        {:ok, "Methionine"}

      "UGG" ->
        {:ok, "Tryptophan"}

      codon when codon == "UGU" or codon == "UGC" ->
        {:ok, "Cysteine"}

      codon when codon == "UUA" or codon == "UUG" ->
        {:ok, "Leucine"}

      codon when codon == "UUU" or codon == "UUC" ->
        {:ok, "Phenylalanine"}

      codon when codon == "UAU" or codon == "UAC" ->
        {:ok, "Tyrosine"}

      codon when codon == "UAA" or codon == "UAG" or codon == "UGA" ->
        {:ok, "STOP"}

      codon when codon == "UCU" or codon == "UCC" or codon == "UCA" or codon == "UCG" ->
        {:ok, "Serine"}

      _ ->
        {:error, "invalid codon"}
    end
  end

  defp decode_rna(codon_list) do
    codon_list
    |> Enum.split_while(fn x -> x !== {:ok, "STOP"} end)
    |> elem(0)
    |> Enum.map(fn {_atom, string} -> string end)
  end
end
