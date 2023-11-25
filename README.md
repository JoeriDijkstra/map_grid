# MapGrid

MapGrid allows you to convert an array of maps or structs to a tabular structure,
which includes the key on top and adds the values below as arrays. Usefull for
ecto queries exporting to CSV using nimble_csv for instance.

## Installation

The package can be installed by adding `map_grid` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:map_grid, "~> 0.1.0"}
  ]
end
```

The docs can be found at <https://hexdocs.pm/map_grid>.

