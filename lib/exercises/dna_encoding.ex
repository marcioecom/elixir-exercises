defmodule DNA do
  def encode_nucleotide(code_point) do
    cond do
      code_point == ?\s -> 0b0000
      code_point == ?A -> 0b0001
      code_point == ?C -> 0b0010
      code_point == ?G -> 0b0100
      code_point == ?T -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
     cond do
      encoded_code == 0b0000 -> ?\s
      encoded_code == 0b0001 -> ?A
      encoded_code == 0b0010 -> ?C
      encoded_code == 0b0100 -> ?G
      encoded_code == 0b1000 -> ?T
    end
  end

  def encode([]), do: <<>>
  def encode([head | tail]), do: <<encode_nucleotide(head)::4, encode(tail)::bitstring>>

  def decode(<<>>), do: []
  def decode(<<head::4, tail::bitstring>>), do: [decode_nucleotide(head) | decode(tail)]
end
