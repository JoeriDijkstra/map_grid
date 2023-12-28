defmodule MapGridTest do
  use ExUnit.Case
  doctest MapGrid

  test "can convert" do
    maps = [%{name: "john", age: 99}, %{name: "doe", age: 100}]
    assert [[:name, :age], ["john", 99], ["doe", 100]] == MapGrid.convert(maps)
  end

  test "empty" do
    maps = []
    assert [] == MapGrid.convert(maps)
  end

  test "uneven amount of values in map" do
    maps = [%{name: "john", age: 99}, %{name: "doe", age: 100, desc: "some description"}]

    assert [[:name, :age], ["john", 99], ["doe", "some description", 100]] ==
             MapGrid.convert(maps)
  end

  test "with a function" do
    maps = [%{name: "john", age: 99}, %{name: "doe", age: 100}]

    function = fn x ->
      Map.put(x, :batch, 3)
    end

    assert [[:name, :batch, :age], ["john", 3, 99], ["doe", "some description", 3, 100]] ==
             MapGrid.convert(maps, item_function: function)
  end

  test "with keys" do
    maps = [%{name: "john", age: 99, gender: "male"}, %{name: "doe", age: 100, gender: "male"}]

    assert [[:name, :age], ["john", 99], ["doe", 100]] ==
             MapGrid.convert(maps, keys: [:name, :age])
  end
end
