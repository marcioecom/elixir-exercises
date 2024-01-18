defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &is_nil(&1.price))
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(&%{&1 | name: String.replace(&1.name, old_word, new_word)})
  end

  def increase_quantity(%{quantity_by_size: sizes} = item, count) do
    %{
      item
      | quantity_by_size: Map.new(sizes, fn {key, value} -> {key, value + count} end)
    }
  end

  def total_quantity(%{quantity_by_size: sizes}) do
    Enum.reduce(sizes, 0, fn {_key, value}, acc -> value + acc end)
  end
end
