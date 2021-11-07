defmodule Exercism.AST.TopSecret do
  @moduledoc """
  You're part of a task force fighting against corporate espionage. You have a secret informer at Shady Company X, which you suspect of stealing secrets from its competitors.

  Your informer, Agent Ex, is an Elixir developer. She is encoding secret messages in her code.

  To decode her secret messages:

  Take all functions (public and private) in the order they're defined in.
  For each function, take the first n characters from its name, where n is the function's arity.
  """

  @type ast ::
          atom
          | binary
          | list
          | number
          | {any, any}
          | {atom | {any, list, atom | list}, keyword, atom | list}

  @spec to_ast(String.t()) :: ast
  @doc """
  Implement the TopSecret.to_ast/1 function. It should take a string with Elixir code and return its AST.

  ### Example

  iex> TopSecret.to_ast("div(4, 3)")
  {:div, [line: 1], [4, 3]}
  """
  def to_ast(string), do: Code.string_to_quoted!(string)

  @doc """
  Implement the TopSecret.decode_secret_message_part/2 function. It should take an AST node and an accumulator for the secret message (a list). It should return a tuple with the AST node unchanged as the first element, and the accumulator as the second element.

  If the operation of the AST node is defining a function (def or defp), prepend the function name (changed to a string) to the accumulator. If the operation is something else, return the accumulator unchanged.

  Extend the TopSecret.decode_secret_message_part/2 function. If the operation in the AST node is defining a function, don't return the whole function name. Instead, check the function's arity. Then, return only first n character from the name, where n is the arity.

  Extend the TopSecret.decode_secret_message_part/2 function. Make sure the function's name and arity is correctly detected for function definitions that use guards.

  ### Examples

  iex> ast_node = TopSecret.to_ast("10 + 3")
  iex> TopSecret.decode_secret_message_part(ast_node, ["day"])
  {ast_node, ["day"]}

  iex> ast_node = TopSecret.to_ast("defp cat(), do: nil")
  iex> TopSecret.decode_secret_message_part(ast_node, ["day"])
  {ast_node, ["", "day"]}

  """
  def decode_secret_message_part(ast, acc) do
    case elem(ast, 0) do
      :def -> {ast, get_message(ast, acc)}
      :defp -> {ast, get_message(ast, acc)}
      _ -> {ast, acc}
    end
  end

  @doc """
  Implement the TopSecret.decode_secret_message/1 function. It should take a string with Elixir code and return the secret message as a string decoded from all function definitions found in the code. Make sure to reuse functions defined in previous steps.
  """
  def decode_secret_message(string) do
    string
    |> check_for_multiple_modules()
    |> get_functions()
    |> handle_functions()
    |> decode_final_message()
  end

  defp get_message(ast, acc) do
    function_tuple = get_function_tuple(ast)

    number_of_arguments = get_number_of_arguments(function_tuple)

    message = handle_arity(number_of_arguments, function_tuple)

    [message | acc]
  end

  defp handle_arity(0, _function_tuple) do
    ""
  end

  defp handle_arity(number_of_arguments, function_tuple) do
    elem(function_tuple, 0)
    |> Atom.to_string()
    |> String.split_at(number_of_arguments)
    |> elem(0)
  end

  defp get_number_of_arguments(function_tuple) do
    arguments = elem(function_tuple, 2)

    if arguments, do: Enum.count(arguments), else: 0
  end

  defp get_function_tuple(ast) do
    first_element = elem(ast, 2) |> List.first() |> elem(0)

    if first_element == :when do
      ast
      |> elem(2)
      |> List.first()
      |> elem(2)
      |> List.first()
    else
      ast |> elem(2) |> List.first()
    end
  end

  defp do_decode([], acc), do: acc

  defp do_decode([head | tail], acc) do
    acc = decode_secret_message_part(head, acc) |> elem(1)

    do_decode(tail, acc)
  end

  defp check_for_multiple_modules(string) do
    ast = to_ast(string)

    first_tuple_element = elem(ast, 0)
    first_list_element = ast |> elem(2) |> List.first() |> elem(0)

    if first_tuple_element == :__block__ and first_list_element == :defmodule do
      get_functions(elem(ast, 2))
    else
      get_functions(ast)
    end
  end

  defp get_functions(ast) when is_list(ast), do: do_get_functions(ast, [])

  defp get_functions(ast) do
    if elem(ast, 0) != :defmodule do
      ast
    else
      ast |> elem(2) |> Enum.fetch!(1) |> Keyword.get(:do)
    end
  end

  defp do_get_functions([], acc), do: acc

  defp do_get_functions([head | tail], acc) do
    do_get_functions(tail, [get_functions(head) | acc])
  end

  defp handle_functions(functions) when is_list(functions), do: do_handle_functions(functions, [])

  defp handle_functions(functions) do
    third_element = functions |> elem(2) |> List.first() |> elem(0)

    if third_element !== :def do
      do_decode([functions], [])
    else
      functions |> elem(2) |> do_decode([])
    end
  end

  defp do_handle_functions([], acc), do: acc

  defp do_handle_functions([head | tail], acc) do
    do_handle_functions(tail, [handle_functions(head) | acc])
  end

  defp decode_final_message(message) do
    if Enum.count(message) > 1 do
      message
      |> List.flatten()
      |> Enum.reverse()
      |> List.to_string()
    else
      message
      |> Enum.reverse()
      |> List.to_string()
    end
  end
end
