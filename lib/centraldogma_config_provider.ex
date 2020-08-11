defmodule CentralDogmaConfigProvider do
  @moduledoc """
  Central Dogma backend for Config.Provider
  """

  require Logger

  @behaviour Config.Provider

  @impl true
  def init(opts) do
    opts
  end

  @impl true
  def load(config, opts) do
    {:ok, _} = Application.ensure_all_started(:finch)
    {:ok, _} = Application.ensure_all_started(:jason)

    Finch.start_link(name: CentralDogmaFinch)

    endpoint = Keyword.get(opts, :endpoint)
    project = Keyword.get(opts, :project)
    repository = Keyword.get(opts, :repository)
    app = Keyword.get(opts, :app)
    path = Keyword.get(opts, :path)

    Finch.build(
      :get,
      build_url(endpoint, project, repository, path),
      [{"Authorization", "Bearer anonymous"}]
    )
    |> Finch.request(CentralDogmaFinch)
    |> case do
      {:ok, %Finch.Response{body: body, status: 200}} ->
        new_config =
          Keyword.put(
            [],
            app,
            Jason.decode!(body, keys: :atoms)
            |> Map.get(:content)
            |> Enum.map(fn {key, value} -> {key, value} end)
          )

        Config.Reader.merge(config, new_config)

      {:ok, %Finch.Response{body: body}} ->
        Logger.error("Cannot fetch configuration from CentralDogma, cause: #{body}")
        config

      {:error, error} ->
        Logger.error("Finch request error, cause: #{inspect(error)}")
        config
    end
  end

  defp build_url(endpoint, project, repository, path) do
    "#{endpoint}/api/v1/projects/#{project}/repos/#{repository}/contents/#{path}"
  end
end
