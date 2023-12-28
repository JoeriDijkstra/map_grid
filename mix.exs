defmodule MapGrid.MixProject do
  use Mix.Project

  def project do
    [
      app: :map_grid,
      version: "1.0.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),

      # Docs
      name: "MapGrid",
      source_url: "https://github.com/JoeriDijkstra/map_grid",
      homepage_urL: "joeridijkstra.com"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    """
    MapGrid allows you to convert an array of maps or structs to a tabular structure,
    which includes the key on top and adds the values below as arrays. Usefull for
    ecto queries exporting to CSV using nimble_csv for instance.
    """
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      licenses: ["GPL-3.0-or-later"],
      links: %{"GitHub" => "https://github.com/JoeriDijkstra/map_grid"}
    ]
  end
end
