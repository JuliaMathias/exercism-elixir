defmodule Exercism.RPG.CharacterSheet do
  @moduledoc """
  You and your friends love to play pen-and-paper role-playing games, but you noticed that it's difficult to get new people to join your group. They often struggle with character creation. They don't know where to start. To help new players out, you decided to write a small program that will guide them through the process.
  """

  @spec welcome :: :ok
  @doc """
  Implement the CharacterSheet.welcome/0 function. It should print a welcome message, and return :ok.

  ## Example
    iex> CharacterSheet.welcome()
    "Welcome! Let's fill out your character sheet together."
    :ok
  """
  def welcome, do: IO.puts("Welcome! Let's fill out your character sheet together.")

  @spec ask_name :: binary
  @doc """
  Implement the RPG.CharacterSheet.ask_name/0 function. It should print a question, wait for an answer, and return the answer without leading and trailing whitespace.
  """
  def ask_name do
    name = IO.gets("What is your character's name?\n")

    String.trim(name)
  end

  @spec ask_class :: binary
  @doc """
  Implement the RPG.CharacterSheet.ask_class/0 function. It should print a question, wait for an answer, and return the answer without leading and trailing whitespace.

  """
  def ask_class do
    class = IO.gets("What is your character's class?\n")

    String.trim(class)
  end

  @spec ask_level :: integer
  @doc """
  Implement the RPG.CharacterSheet.ask_level/0 function. It should print a question, wait for an answer, and return the answer as an integer.

  """
  def ask_level do
    level = IO.gets("What is your character's level?\n")

    level
    |> String.trim()
    |> String.to_integer()
  end

  @spec run :: %{class: binary, level: integer, name: binary}
  @doc """
  Implement the RPG.CharacterSheet.run/0 function. It should welcome the new player, ask for the character's name, class, and level, and return the character sheet as a map. It should also print the map with the label "Your character".

  """
  def run do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()

    character_map = %{class: class, level: level, name: name}

    IO.inspect(character_map, label: "Your character")
  end
end
