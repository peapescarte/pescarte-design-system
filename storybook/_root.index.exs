defmodule Storybook.Root do
  # See https://hexdocs.pm/phoenix_storybook/PhoenixStorybook.Index.html for full index
  # documentation.

  use PhoenixStorybook.Index

  def entry("welcome") do
    [name: "Apresentação do Projeto"]
  end
end
