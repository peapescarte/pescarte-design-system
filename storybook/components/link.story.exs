defmodule Storybook.Components.Link do
  use PhoenixStorybook.Story, :component

  def a(assigns), do: DesignSystem.link(assigns)

  def function, do: &__MODULE__.a/1
  def imports, do: [{DesignSystem, text: 1}]

  def variations do
    [
      %Variation{
        id: :default_style,
        attributes: %{
          navigate: "/app/dashboard"
        },
        slots: [~s|Dashboard|]
      },
      %Variation{
        id: :without_style,
        attributes: %{
          href: "https://www.example.com",
          styless: true
        },
        slots: [~s|Visite Example.com|]
      }
    ]
  end
end
