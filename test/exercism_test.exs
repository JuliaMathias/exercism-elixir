defmodule ExercismTest do
  use ExUnit.Case
  doctest Exercism

  test "greets the world" do
    assert Exercism.hello() == :world
  end
end
