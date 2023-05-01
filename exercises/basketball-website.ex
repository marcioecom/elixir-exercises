defmodule BasketballWebsite do
  defp do_extract_from_path(data, []), do: data
  defp do_extract_from_path(data, [head | rest]), do: do_extract_from_path(data[head], rest)

  def extract_from_path(data, path) do
    do_extract_from_path(data, keys(path))
  end

  def get_in_path(data, path) do
    get_in(data, keys(path))
  end

  defp keys(path) do
    String.split(path, ".", trim: true)
  end
end

data = %{
  "team_mascot" => %{
    "animal" => "bear",
    "actor" => %{
      "first_name" => "Noel"
    }
  }
}

IO.puts BasketballWebsite.extract_from_path(data, "team_mascot.animal")
IO.puts BasketballWebsite.get_in_path(data, "team_mascot.animal")
