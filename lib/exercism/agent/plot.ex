defmodule Exercism.Agent.Plot do
  @moduledoc """
  Defines the Plot struct.
  """
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end
