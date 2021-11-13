defmodule Exercism.Alias.NeedForSpeed do
  @moduledoc """
  That remote controlled car that you bought recently has turned into a whole new hobby. You have been organizing remote control car races.

  You were almost finished writing a program that would allow to run race simulations when your cat jumped at your keyboard and deleted a few lines of code. Now your program doesn't compile anymore...
  """
  import IO, only: [puts: 1]
  import IO.ANSI, except: [color: 1]

  alias Exercism.Alias.NeedForSpeed.Race
  alias Exercism.Alias.NeedForSpeed.RemoteControlCar, as: Car

  # Do not edit the code below.

  def print_race(%Race{} = race) do
    puts("""
    🏁 #{race.title} 🏁
    Status: #{Race.display_status(race)}
    Distance: #{Race.display_distance(race)}

    Contestants:
    """)

    race.cars
    |> Enum.sort_by(&(-1 * &1.distance_driven_in_meters))
    |> Enum.with_index()
    |> Enum.each(fn {car, index} -> print_car(car, index + 1) end)
  end

  defp print_car(%Car{} = car, index) do
    color = color(car)

    puts("""
      #{index}. #{color}#{car.nickname}#{default_color()}
      Distance: #{Car.display_distance(car)}
      Battery: #{Car.display_battery(car)}
    """)
  end

  defp color(%Car{} = car) do
    case car.color do
      :red -> red()
      :blue -> cyan()
      :green -> green()
    end
  end
end
