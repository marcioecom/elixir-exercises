defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, 100.00)

    for top <- tops,
        bottom <- bottoms,
        different_color?(top, bottom),
        within_budget?(top, bottom, max_price) do
      {top, bottom}
    end
  end

  defp different_color?(top, bottom), do: top.base_color != bottom.base_color

  defp within_budget?(top, bottom, max_price), do: top.price + bottom.price <= max_price
end

tops = [
  %{item_name: "Dress shirt", base_color: "blue", price: 35},
  %{item_name: "Casual shirt", base_color: "black", price: 20}
]

bottoms = [
  %{item_name: "Jeans", base_color: "blue", price: 30},
  %{item_name: "Dress trousers", base_color: "black", price: 75}
]

IO.inspect(BoutiqueSuggestions.get_combinations(tops, bottoms, maximum_price: 50))
