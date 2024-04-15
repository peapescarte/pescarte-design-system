defmodule Storybook.Components.Inputs.Radio do
  use PhoenixStorybook.Story, :component
  alias DesignSystem

  def function, do: &DesignSystem.radio/1
  def imports, do: [{DesignSystem, [simple_form: 1]}]

  def template do
    """
    <.simple_form :let={f} for={%{}} as={:story} class="w-full">
      <.psb-variation-group field={f[:field]}/>
    </.simple_form>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :radio_group,
        variations: [
          %Variation{
            id: :not_checked,
            attributes: %{},
            slots: [
              ~s|<:label>Opção 1</:label>|
            ]
          },
          %Variation{
            id: :checked,
            attributes: %{checked: true},
            slots: [
              ~s|<:label>Opção 2</:label>|
            ]
          }
        ]
      }
    ]
  end
end
