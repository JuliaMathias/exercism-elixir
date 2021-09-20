defmodule Exercism.Maps.HighScore do
  @moduledoc """
  In this exercise, you're implementing a way to keep track of the high scores for the most popular game in your local arcade hall.
  """

  @initial_score 0

  @spec new :: %{}
  @doc """
  To make a new high score map, define the HighScore.new/0 function which doesn't take any arguments and returns a new, empty map of high scores.

  ## Example
    iex> HighScore.new()
    %{}
  """
  def new, do: %{}

  @spec add_player(map, binary, number) :: map
  @doc """
  To add a player to the high score map, define HighScore.add_player/3, which is a function which takes 3 arguments:

  The first argument is the map of scores.
  The second argument is the name of a player as a string.
  The third argument is the score as an integer. The argument is optional, implement the third argument with a default value of 0.
  Store the default initial score in a module attribute. It will be needed again.

  ## Examples
    iex> HighScore.new() |> HighScore.add_player("Dave Thomas") |> HighScore.add_player("José Valim", 486_373)
    %{"Dave Thomas" => 0, "José Valim"=> 486_373}
  """
  def add_player(scores, name, score \\ @initial_score), do: Map.put(scores, name, score)

  @spec remove_player(map, binary) :: map
  @doc """
  To remove a player from the high score map, define HighScore.remove_player/2, which takes 2 arguments:

  The first argument is the map of scores.
  The second argument is the name of the player as a string.

  ## Example
    iex> HighScore.new() |> HighScore.add_player("Dave Thomas") |> HighScore.remove_player("Dave Thomas")
    %{}
  """
  def remove_player(scores, name), do: Map.delete(scores, name)

  @spec reset_score(map, binary) :: map
  @doc """
  To reset a player's score, define HighScore.reset_score/2, which takes 2 arguments:

  The first argument is the map of scores.
  The second argument is the name of the player as a string, whose score you wish to reset.

  ## Example
    iex> HighScore.new() |> HighScore.add_player("José Valim", 486_373) |> HighScore.reset_score("José Valim")
    %{"José Valim"=> 0}
  """
  def reset_score(scores, name), do: Map.put(scores, name, @initial_score)

  @spec update_score(map, binary, number) :: map
  @doc """
  To update a player's score by adding to the previous score, define HighScore.update_score/3, which takes 3 arguments:

  The first argument is the map of scores.
  The second argument is the name of the player as a string, whose score you wish to update.
  The third argument is the score that you wish to add to the stored high score.

  ## Example
    iex> HighScore.new() |> HighScore.add_player("José Valim", 486_373) |> HighScore.update_score("José Valim", 5)
    %{"José Valim"=> 486_378}
  """
  def update_score(scores, name, score \\ @initial_score) do
    Map.update(scores, name, score, fn value -> value + score end)
  end

  @spec get_players(map) :: list
  @doc """
  To get a list of players, define HighScore.get_players/1, which takes 1 argument:

  The first argument is the map of scores.

  ## Example
    iex> HighScore.new() |> HighScore.add_player("Dave Thomas") |> HighScore.add_player("José Valim", 486_373) |> HighScore.get_players()
    ["Dave Thomas", "José Valim"]
  """
  def get_players(scores), do: Map.keys(scores)
end
