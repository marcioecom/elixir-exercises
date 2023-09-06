# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {0, []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_, plots} -> plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {id, plots} = state ->
      IO.inspect state
      plot = new_plot(id+1, register_to)

      {plot, {id + 1, [plot | plots]}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {id, plots} ->
      {id, Enum.filter(plots, &(&1.plot_id != plot_id))}
    end)
  end

  def get_registration(pid, plot_id) do
    list_registrations(pid)
    |> Enum.find({:not_found, "plot is unregistered"}, &(&1.plot_id == plot_id))
  end

  defp new_plot(id, registered_to), do: %Plot{plot_id: id, registered_to: registered_to}
end
