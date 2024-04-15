defmodule Storybook.Components.Button do
  use PhoenixStorybook.Story, :component

  def function, do: &DesignSystem.button/1

  def variations do
    [
      %Variation{
        id: :primary_button,
        attributes: %{
          style: "primary",
          click: "handle_click",
          class: "px-4 py-2 rounded-lg shadow-md hover:shadow-lg transition-shadow"
        },
        slots: [~s|Click Me|]
      },
      %Variation{
        id: :secondary_button,
        attributes: %{
          style: "secondary",
          click: "handle_click",
          class: "px-4 py-2 rounded-lg border border-blue-500 hover:bg-blue-100 transition-colors"
        },
        slots: [~s|Learn More|]
      },
      %Variation{
        id: :primary_with_icon,
        attributes: %{
          style: "primary",
          click: "handle_click",
          class:
            "px-4 py-2 rounded-lg shadow-md hover:shadow-lg transition-shadow flex items-center space-x-2"
        },
        slots: [~s|<i class="lucide lucide-check-circle"></i>Confirm|]
      },
      %Variation{
        id: :secondary_disabled,
        attributes: %{
          style: "secondary",
          disabled: true,
          class: "px-4 py-2 rounded-lg border border-gray-400 text-gray-400 cursor-not-allowed"
        },
        slots: [~s|Disabled|]
      }
    ]
  end
end
