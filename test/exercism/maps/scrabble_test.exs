defmodule Exercism.Maps.ScrabbleTest do
  use ExUnit.Case
  alias Exercism.Maps.Scrabble

  # @tag :pending
  test "empty word scores zero" do
    assert Scrabble.score("") == 0
  end

  test "whitespace scores zero" do
    assert Scrabble.score(" \t\n") == 0
  end

  test "uppercase letter" do
    assert Scrabble.score("A") == 1
  end

  test "valuable letter" do
    assert Scrabble.score("f") == 4
  end

  test "short word" do
    assert Scrabble.score("at") == 2
  end

  test "short, valuable word" do
    assert Scrabble.score("zoo") == 12
  end

  test "medium word" do
    assert Scrabble.score("street") == 6
  end

  test "medium, valuable word" do
    assert Scrabble.score("quirky") == 22
  end

  test "long, mixed-case word" do
    assert Scrabble.score("OxyphenButazone") == 41
  end

  test "english-like word" do
    assert Scrabble.score("pinata") == 8
  end

  test "entire alphabet available" do
    assert Scrabble.score("abcdefghijklmnopqrstuvwxyz") == 87
  end
end
