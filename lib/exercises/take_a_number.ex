defmodule TakeANumber do
  @first_num 0

  def start(), do: spawn(&handle/0)

  defp handle(num \\ @first_num) do
    receive do
      {:report_state, from} ->
        send(from, num)
        handle(num)

      {:take_a_number, from} ->
        send(from, num + 1)
        handle(num + 1)

      :stop ->
        Process.exit(self(), :kill)

      _ ->
        handle(num)
    end
  end
end
