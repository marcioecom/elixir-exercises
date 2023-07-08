defmodule KitchenCalculator do
  def get_volume(volume_pair), do: elem(volume_pair, 1)

  def to_milliliter({:cup, value}), do: {:milliliter, value * 240 }

  def to_milliliter({:fluid_ounce, value}), do: {:milliliter, value * 30}

  def to_milliliter({:teaspoon, value}), do: {:milliliter, value * 5}

  def to_milliliter({:tablespoon, value}), do: {:milliliter, value * 15}

  def to_milliliter({:milliliter, value}), do: {:milliliter, value}

  def from_milliliter(volume_pair, :cup) do
    value = elem(volume_pair, 1) / 240
    {:cup, value}
  end

  def from_milliliter(volume_pair, :fluid_ounce) do
    value = elem(volume_pair, 1) / 30
    {:fluid_ounce, value}
  end

  def from_milliliter(volume_pair, :teaspoon) do
    value = elem(volume_pair, 1) / 5
    {:teaspoon, value}
  end

  def from_milliliter(volume_pair, :tablespoon) do
    value = elem(volume_pair, 1) / 15
    {:tablespoon, value}
  end

  def from_milliliter(volume_pair, :milliliter) do
    value = elem(volume_pair, 1)
    {:milliliter, value}
  end

  def convert(volume_pair, unit) do
    to_milliliter(volume_pair)
    |> from_milliliter(unit)
  end
end
