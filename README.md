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

## Contributing
To contribute, first clone the repository and then install the dependencies:
`mix deps.get`
Make sure the tests pass:
`mix test`
Make your change, add tests for your change, and make sure they pass again:
`mix test`
Push to a non-master branch and submit a pull request. 

Some things to keep in mind to get your pull request approved:
- Write tests
- Write documentation
- Put some thought in your commit message, should start with fix, feature or chore followed by a colon
- Try to match the current style / file structure

Thank you for contributing!