defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0
  ]

  def new(nickname \\ "none") do
    %__MODULE__{nickname: nickname}
  end

  def display_distance(%__MODULE__{distance_driven_in_meters: distance }) do
    "#{distance} meters"
  end

  def display_battery(%__MODULE__{battery_percentage: battery }) do
    case battery do
      0 -> "Battery empty"
      percentage -> "Battery at #{percentage}%"
    end
  end

  def drive(%__MODULE__{battery_percentage: 0} = remote_car) do
    remote_car
  end

  def drive(%__MODULE__{battery_percentage: battery, distance_driven_in_meters: distance } = remote_car) do
    %__MODULE__{
      remote_car |
      battery_percentage: battery - 1,
      distance_driven_in_meters: distance + 20
    }
  end
end
