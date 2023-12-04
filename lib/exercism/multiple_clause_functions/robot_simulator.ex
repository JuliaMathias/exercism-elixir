defmodule Exercism.MultipleClauseFunctions.RobotSimulator do
  @type robot() :: %{position: position(), direction: direction()}
  @type direction() :: :north | :east | :south | :west | nil
  @type position() :: {integer(), integer()} | nil

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ nil, position \\ nil)
  def create(nil, nil), do: %{position: {0, 0}, direction: :north}

  def create(direction, position) do
    with {:ok, direction} <- check_direction(direction),
         {:ok, position} <- check_position(position) do
      %{position: position, direction: direction}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions) do
    with instructions <- String.split(instructions, "", trim: true),
         {:ok, instructions} <- check_instructions(instructions) do
      Enum.reduce(instructions, robot, fn step, robot -> execute_step(robot, step) end)
    end
  end

  defp execute_step(robot, step) do
    case step do
      "R" -> turn_right(robot)
      "L" -> turn_left(robot)
      "A" -> advance(robot)
    end
  end

  defp turn_right(%{direction: direction} = robot) do
    %{robot | direction: turn_right(direction)}
  end

  defp turn_right(direction) do
    case direction do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
  end

  defp turn_left(%{direction: direction} = robot) do
    %{robot | direction: turn_left(direction)}
  end

  defp turn_left(direction) do
    case direction do
      :north -> :west
      :east -> :north
      :south -> :east
      :west -> :south
    end
  end

  defp advance(%{position: position, direction: direction} = robot) do
    %{robot | position: advance(position, direction)}
  end

  defp advance(position, direction) do
    case direction do
      :north -> {elem(position, 0), elem(position, 1) + 1}
      :east -> {elem(position, 0) + 1, elem(position, 1)}
      :south -> {elem(position, 0), elem(position, 1) - 1}
      :west -> {elem(position, 0) - 1, elem(position, 1)}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot), do: robot.direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot), do: robot.position

  defp check_direction(direction) do
    cond do
      is_nil(direction) -> {:ok, :north}
      direction in [:north, :east, :south, :west] -> {:ok, direction}
      true -> {:error, "invalid direction"}
    end
  end

  defp check_position(position) when is_tuple(position) do
    case position do
      {a, b} when is_integer(a) and is_integer(b) -> {:ok, {a, b}}
      _ -> {:error, "invalid position"}
    end
  end

  defp check_position(_position), do: {:error, "invalid position"}

  defp check_instructions(instructions) do
    if Enum.all?(instructions, fn instruction -> instruction in ["R", "L", "A"] end) do
      {:ok, instructions}
    else
      {:error, "invalid instruction"}
    end
  end
end
