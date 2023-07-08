defmodule Secrets do
  def secret_add(secret) do
    # &(&1 + secret)
    fn n -> n + secret end
  end

  def secret_subtract(secret) do
    # &(&1 - secret)
    fn n -> n - secret end
  end

  def secret_multiply(secret) do
    # &(&1 * secret)
    fn n -> n * secret end
  end

  def secret_divide(secret) do
    # &(&1 / secret)
    fn n -> div(n, secret) end
  end

  def secret_and(secret) do
    # &(Bitwise.band(&1, secret))
    fn n -> Bitwise.band(n, secret) end
  end

  def secret_xor(secret) do
    # &(Bitwise.bxor(&1, secret))
    fn n -> Bitwise.bxor(n, secret) end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn param ->
      secret_function2.(secret_function1.(param))
    end
  end
end
