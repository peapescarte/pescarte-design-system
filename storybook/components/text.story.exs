defmodule Storybook.CoreComponents.Text do
  use PhoenixStorybook.Story, :component

  def function, do: &DesignSystem.text/1

  def variations do
    [
      %Variation{
        id: :headline,
        attributes: %{
          size: "h1",
          color: "text-black-80",
          class: "mb-4"
        },
        slots: [~s|Boas vindas a Plataforma Pescarte|]
      },
      %Variation{
        id: :subheadline,
        attributes: %{
          size: "h2",
          color: "text-black-80",
          class: "mb-3"
        },
        slots: [~s|Explore the Features|]
      },
      %Variation{
        id: :subheadline2,
        attributes: %{
          size: "h3",
          color: "text-black-80",
          class: "mb-3"
        },
        slots: [~s|Explore the Features|]
      },
      %Variation{
        id: :subheadline3,
        attributes: %{
          size: "h4",
          color: "text-black-80",
          class: "mb-3"
        },
        slots: [~s|Explore the Features|]
      },
      %Variation{
        id: :subheadline4,
        attributes: %{
          size: "h5",
          color: "text-black-80",
          class: "mb-3"
        },
        slots: [~s|Explore the Features|]
      },
      %Variation{
        id: :body_text_large,
        attributes: %{
          size: "lg",
          color: "text-black-80"
        },
        slots: [
          ~s|Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor.|
        ]
      },
      %Variation{
        id: :body_text,
        attributes: %{
          size: "base",
          color: "text-black-80"
        },
        slots: [
          ~s|Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor.|
        ]
      },
      %Variation{
        id: :caption,
        attributes: %{
          size: "sm",
          color: "text-black-80"
        },
        slots: [~s|Note: This is an important update.|]
      }
    ]
  end
end
