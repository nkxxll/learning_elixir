defmodule Tokenizer do
  @moduledoc """
  This modules should teach me the use of lists and strings by building a
  simple tokenizer for a simple language 
  """

  @line 1

  defmodule Token do
    defstruct [:type, :line, :literal]
  end

  def tokenize(input), do: tokenize(input, [])

  defp tokenize(<<>>, acc), do: Enum.reverse(acc)

  defp tokenize(input, acc) do
    {token, rest} = next(input)

    case token.type do
      :eof -> Enum.reverse(acc)
      # skip whitespace if desired
      :ws -> tokenize(rest, acc)
      _ -> tokenize(rest, [token | acc])
    end
  end

  def next(<<>>), do: {%Token{type: :eof, line: @line, literal: ""}, ""}

  def next(<<"\n", rest::binary>>) do
    {%Token{type: :ws, line: @line + 1, literal: "\n"}, rest}
  end

  def next(<<"+", rest::binary>>) do
    {%Token{type: :plus, line: @line, literal: "+"}, rest}
  end

  def next(<<"-", rest::binary>>) do
    {%Token{type: :minus, line: @line, literal: "-"}, rest}
  end

  def next(<<digit, _::binary>> = input) when digit in ?0..?9 do
    parse_number(input)
  end

  def next(<<ws, rest::binary>>) when ws in [?\s, ?\t] do
    {%Token{type: :ws, line: @line, literal: <<ws>>}, rest}
  end

  def parse_number(input), do: do_parse_number(input, "")

  defp do_parse_number(<<digit, rest::binary>>, acc) when digit in ?0..?9 do
    do_parse_number(rest, acc <> <<digit>>)
  end

  defp do_parse_number(rest, acc) do
    {%Token{type: :number, line: @line, literal: acc}, rest}
  end
end
