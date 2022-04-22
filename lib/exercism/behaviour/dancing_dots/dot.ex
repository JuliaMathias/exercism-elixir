defmodule Exercism.Behaviour.DancingDots.Dot do
  defstruct [:x, :y, :radius, :opacity]
  @type t :: %__MODULE__{}
end
