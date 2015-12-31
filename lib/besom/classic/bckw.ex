defmodule Besom.Classic.BCKW do
  import Besom.Classic.SKI, only: [k: 2]
  import Besom.Curry, only: [curry: 1]

  @doc ~S"""
  Normal (binary) function composition
  """
  @spec b((... -> any), (... -> any), any) :: any
  def b(x, y, z), do: curry(x).(curry(y).(z))

  @doc ~S"""
  Reverse (first) two arguments (`flip`)
  """
  @spec c((... -> any)) :: (... -> any)
  def c(fun), do: &(curry(fun).(&2).(&1))

  @doc ~S"""
  Apply the same argument to a functon twice

      iex> add = &(&1 + &2)
      iex> w(add).(1)
      2

      iex> partial_zip = w(&Enum.zip/2)
      iex> {_, arity} :erlang.fun_info(partial_zip, :arity)
      1

      iex> w(&Enum.zip/2).([1,2,3])
      [{1, 1}, {2, 2}, {3, 3}]

      iex> {_, arity} :erlang.fun_info(w(&Enum.into).([1,2,3]), :arity)
      1

  """
  @spec w(... -> any) :: any
  def w(fun), do: &(curry(fun).(&1).(&1))
end
