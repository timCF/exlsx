defmodule Exlsx.Mixfile do
  use Mix.Project

  def project do
    [app: :exlsx,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications:  [
                      :logger,
                      :silverb,
                      :csvex,
                      :exutils,
                      :logex
                    ],
     mod: {Exlsx, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:silverb, github: "timCF/silverb"},
      {:csvex, github: "timCF/csvex"},
      {:exutils, github: "timCF/exutils"},
      {:logex, github: "timCF/logex"}
    ]
  end
end
