defmodule Exercism.Structs.RemoteControlCar do
  @moduledoc """
  In this exercise you'll be playing around with a remote controlled car, which you've finally saved enough money for to buy.

  Cars start with full (100%) batteries. Each time you drive the car using the remote control, it covers 20 meters and drains one percent of the battery. The car's nickname is not known until it is created.

  The remote controlled car has a fancy LED display that shows two bits of information:

    - The total distance it has driven, displayed as: "<METERS> meters".
    - The remaining battery charge, displayed as: "Battery at <PERCENTAGE>%".

  If the battery is at 0%, you can't drive the car anymore and the battery display will show "Battery empty".
  """
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  @type remote_control_car :: %Exercism.Structs.RemoteControlCar{
          battery_percentage: integer,
          distance_driven_in_meters: integer,
          nickname: String.t()
        }

  @spec new :: remote_control_car
  @doc """
  Implement the RemoteControlCar.new/0 function to return a brand-new remote controlled car struct:

  ### Example

  iex> RemoteControlCar.new()
  %Exercism.Structs.RemoteControlCar{battery_percentage: 100, distance_driven_in_meters: 0, nickname: "none"}
  """
  def new, do: new("none")

  @spec new(String.t()) :: remote_control_car
  @doc """
  Implement the RemoteControlCar.new/1 function to return a brand-new remote controlled car struct with a provided nickname:

  ### Example

  iex> RemoteControlCar.new("Blue")
  %Exercism.Structs.RemoteControlCar{battery_percentage: 100,      distance_driven_in_meters: 0,nickname: "Blue"}
  """
  def new(nickname), do: %Exercism.Structs.RemoteControlCar{nickname: nickname}

  @spec display_distance(remote_control_car) :: String.t()
  @doc """
  Implement the RemoteControlCar.display_distance/1 function to return the distance as displayed on the LED display:

  ### Example

  iex> car = RemoteControlCar.new()
  iex> RemoteControlCar.display_distance(car)
  "0 meters"
  """

  def display_distance(remote_car), do: "#{remote_car.distance_driven_in_meters} meters"

  @spec display_battery(remote_control_car) :: String.t()
  @doc """
  Implement the RemoteControlCar.display_battery/1 function to return the battery percentage as displayed on the LED display:

  ### Example

  iex> car = RemoteControlCar.new()
  iex> RemoteControlCar.display_battery(car)
  "Battery at 100%"
  """
  def display_battery(remote_car) when remote_car.battery_percentage == 0, do: "Battery empty"

  def display_battery(remote_car), do: "Battery at #{remote_car.battery_percentage}%"

  @spec drive(remote_control_car) :: remote_control_car
  @doc """
  Update the RemoteControlCar.drive/1 function to not increase the distance driven nor decrease the battery percentage when the battery is drained (at 0%):

  ### Example

  iex> RemoteControlCar.new("Red") |> RemoteControlCar.drive()
  %Exercism.Structs.RemoteControlCar{battery_percentage: 99, distance_driven_in_meters: 20, nickname: "Red"}

  iex> %Exercism.Structs.RemoteControlCar{battery_percentage: 0, distance_driven_in_meters: 1980, nickname: "Red"} |> RemoteControlCar.drive()
  %Exercism.Structs.RemoteControlCar{battery_percentage: 0, distance_driven_in_meters: 1980, nickname: "Red"}
  """
  def drive(
        %Exercism.Structs.RemoteControlCar{
          battery_percentage: battery_percentage,
          distance_driven_in_meters: distance_driven_in_meters
        } = remote_car
      ) do
    if battery_percentage == 0 do
      remote_car
    else
      remote_car
      |> Map.replace!(:battery_percentage, battery_percentage - 1)
      |> Map.replace!(:distance_driven_in_meters, distance_driven_in_meters + 20)
    end
  end
end
