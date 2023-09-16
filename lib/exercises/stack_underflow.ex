defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(term) do
      case term do
        [] -> %__MODULE__{}
        _ -> %__MODULE__{message: "stack underflow occurred, context: #{term}"}
      end
    end
  end

  def divide(num_list) when length(num_list) != 2 do
    raise StackUnderflowError, "when dividing"
  end

  def divide([0, _dividend]) do
    raise DivisionByZeroError
  end

  def divide([divisor, dividend]) do
    div(dividend, divisor)
  end
end
