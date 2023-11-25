defmodule MapGrid do
  @moduledoc """
  This module has a singular public function, called `convert`. This convert function
  can be used to convert an array of maps, like you would get from an Ecto query,
  and convert them into a tabular data structure, or a grid.
  """

  @doc """
  Function to convert from an array of maps to a tabular data structure.
  Function expects all maps to be equal, like a struct would be.

  ## Examples

      iex > MapGrid.convert([%{name: "john", age: 99}, %{name: "doe", age: 100}])
      [[:name", :age], ["john", 99], ["doe", 100]]
  """
  def convert(maps, opts \\ []) do
    maps
    |> do_convert(nil, opts)
    |> Enum.reverse()
  end

  defp do_convert([], data, _opts), do: data || []

  defp do_convert([item | rest], data, opts) when not is_nil(data) do
    values = Enum.reduce(item, [], fn {_, v}, values -> [v | values] end)
    do_convert(rest, [values | data], opts)
  end

  defp do_convert([item | _] = items, nil, opts) do
    keys = Enum.reduce(item, [], fn {k, _}, keys -> [k | keys] end)
    do_convert(items, [keys], opts)
  end
end
