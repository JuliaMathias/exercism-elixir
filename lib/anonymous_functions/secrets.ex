defmodule Exercism.AnonymousFunctions.Secrets do
  @moduledoc """
  In this exercise, you've been tasked with writing the software for an encryption device that works by performing transformations on data. You need a way to flexibly create complicated functions by combining simpler functions together.

  For each task, return an anonymous function that can be invoked from the calling scope.

  All functions should expect integer arguments. Integers are also suitable for performing bitwise operations in Elixir.
  """

  @spec secret_add(number) :: (number -> number)
  def secret_add(secret), do: fn param -> param + secret end

  @spec secret_subtract(number) :: (number -> number)
  def secret_subtract(secret), do: fn param -> param - secret end

  @spec secret_multiply(number) :: (number -> number)
  def secret_multiply(secret), do: fn param -> param * secret end

  @spec secret_divide(number) :: (number -> number)
  def secret_divide(secret), do: fn param -> div(param, secret) end

  @spec secret_and(integer) :: (integer -> integer)
  def secret_and(secret), do: fn param -> Bitwise.&&&(param, secret) end

  @spec secret_xor(integer) :: (integer -> integer)
  def secret_xor(secret), do: fn param -> Bitwise.^^^(param, secret) end

  @spec secret_combine(fun(), fun()) :: (integer -> integer)
  def secret_combine(secret_function1, secret_function2) do
    fn param -> param |> secret_function1.() |> secret_function2.() end
  end
end
