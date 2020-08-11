# CentraldogmaConfigProvider

LINE Central Dogma config backend for Config.Provider.

## How to use it

Just add this config inside project function (in mix.exs):

      releases: [
        cd_test_app: [
          config_providers: [
            {CentralDogmaConfigProvider,
             endpoint: "<your_central_dogma_endpoint_with_http_scheme>",
             project: "<your_project_name>",
             repository: "<your_repository_name>",
             app: :<app_name>,
             path: "<path>"}
          ]
        ]
      ]

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `centraldogma_config_provider` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:centraldogma_config_provider, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/centraldogma_config_provider](https://hexdocs.pm/centraldogma_config_provider).

