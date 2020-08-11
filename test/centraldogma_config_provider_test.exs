defmodule CentraldogmaConfigProviderTest do
  use ExUnit.Case

  test "load config" do
    opts = [
      endpoint: "http://localhost:36462",
      project: "projectFoo",
      repository: "repoA",
      app: :myapp,
      path: "samples/a.json"
    ]

    opts = CentralDogmaConfigProvider.init(opts)
    config = CentralDogmaConfigProvider.load([myapp: []], opts)
    assert Keyword.get(config, :myapp) == [a: "b"]
  end
end
