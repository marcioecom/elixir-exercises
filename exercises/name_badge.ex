defmodule NameBadge do
  @item_separator " - "
  @owner "OWNER"

  def print(id, name, department) do
    id_part = if id, do: "[#{id}]"
    department_part = if department, do: String.upcase(department), else: @owner

    [id_part, name, department_part]
    |> Enum.reject(&is_nil/1)
    |> Enum.join(@item_separator)
  end
end

IO.puts NameBadge.print(nil, "Márcio", "development")
