defmodule MapGrid do
  @moduledoc """
  This module has a singular public function, called `convert`. This convert function
  can be used to convert an array of maps, like you would get from an Ecto query,
  and convert them into a tabular data structure, or a grid.
  """

  @doc """
  Function to convert from an array of maps to a tabular data structure.
  Function expects all maps to be equal, like a struct would be, but it is not
  limited to structs.

  ## Example

      iex > MapGrid.convert([%{name: "john", age: 99}, %{name: "doe", age: 100}])
      [[:name", :age], ["john", 99], ["doe", 100]]

  ## Options

  ## Item function
  This option allows you to define a function with an arity of one to be executed on each item. The value is an array.

      iex > function = fn Map.put(&1, :batch, 3) end
      iex > MapGrid.convert([%{name: "john", age: 99}, %{name: "doe", age: 100}], item_function: function)
      [[:name, :batch, :age], ["john", 3, 99], ["doe", "some description", 3, 100]]

  ## Keys
  This option expects an array of atoms and defines the **order** of the tabular structure. This is important to be able to
  ignore certain keys and include keys added via the item_function.

      iex > function = fn Map.put(&1, :batch, 3) end
      iex > MapGrid.convert([%{name: "john", age: 99}, %{name: "doe", age: 100}], item_function: function)
      [[:name, :batch, :age], ["john", 3, 99], ["doe", "some description", 3, 100]]
  """
  @spec convert([map()], keyword()) :: list()
  def convert(maps, opts \\ []) do
    maps
    |> do_convert(nil, Enum.into(opts, %{}))
    |> Enum.reverse()
  end

  defp do_convert([], data, _opts), do: data || []

  defp do_convert([item | rest], data, opts) when not is_nil(data) do
    values =
      item
      |> apply_options(opts)
      |> Enum.reduce([], fn {_, v}, values -> [v | values] end)

    do_convert(rest, [values | data], opts)
  end

  defp do_convert([item | _] = items, nil, opts) do
    keys =
      item
      |> apply_options(opts)
      |> Enum.reduce([], fn {k, _}, keys -> [k | keys] end)

    do_convert(items, [keys], opts)
  end

  defp apply_options(item, options) do
    item
    |> apply_function(options)
    |> reduce_to_keys(options)
  end

  defp apply_function(item, %{item_function: function}), do: function.(item)
  defp apply_function(item, _), do: item

  defp reduce_to_keys(item, %{keys: keys}) do
    Enum.reduce(keys, [], &[{&1, Map.get(item, &1)} | &2])
  end

  defp reduce_to_keys(item, _), do: item
end
