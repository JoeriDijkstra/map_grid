defmodule MapGridTest do
  use ExUnit.Case
  doctest MapGrid

  test "can convert" do
    maps = [%{name: "john", age: 99}, %{name: "doe", age: 100}]
    result = Enum.map(MapGrid.convert(maps), &Enum.sort/1)
    assert result == [[:age, :name], [99, "john"], [100, "doe"]]
  end

  test "empty" do
    maps = []
    assert [] == MapGrid.convert(maps)
  end

  test "uneven amount of values in map" do
    maps = [%{name: "john", age: 99}, %{name: "doe", age: 100, desc: "some description"}]
    result = Enum.map(MapGrid.convert(maps), &Enum.sort/1)
    assert [[:age, :name], [99, "john"], [100, "doe", "some description"]] == result
  end

  test "with a function" do
    maps = [%{name: "john", age: 99}, %{name: "doe", age: 100}]

    function = fn x ->
      Map.put(x, :batch, 3)
    end

    converted = MapGrid.convert(maps, item_function: function)
    result = Enum.map(converted, &Enum.sort/1)
    assert [[:age, :batch, :name], [3, 99, "john"], [3, 100, "doe"]] == result
  end

  test "with keys" do
    maps = [%{name: "john", age: 99, gender: "male"}, %{name: "doe", age: 100, gender: "male"}]

    assert [[:name, :age], ["john", 99], ["doe", 100]] ==
             MapGrid.convert(maps, keys: [:name, :age])
  end
end
