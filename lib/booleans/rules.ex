defmodule Exercism.Booleans.Rules do
  @spec eat_ghost?(boolean, boolean) :: boolean
  def eat_ghost?(power_pellet_active, touching_ghost),
    do: if(power_pellet_active and touching_ghost, do: true, else: false)

  @spec score?(boolean, boolean) :: boolean
  def score?(touching_power_pellet, touching_dot),
    do: if(touching_power_pellet or touching_dot, do: true, else: false)

  @spec lose?(boolean, boolean) :: boolean
  def lose?(power_pellet_active, touching_ghost),
    do: if(power_pellet_active == false and touching_ghost, do: true, else: false)

  @spec win?(boolean, boolean, boolean) :: boolean
  def win?(has_eaten_all_dots, power_pellet_active, touching_ghost) do
    if has_eaten_all_dots and lose?(power_pellet_active, touching_ghost) == false do
      true
    else
      false
    end
  end
end
