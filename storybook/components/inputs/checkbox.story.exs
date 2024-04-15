defmodule Storybook.Components.Inputs.Checkbox do
  use PhoenixStorybook.Story, :component

  def function, do: &DesignSystem.checkbox/1
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
      %Variation{
        id: :checkbox_without_label,
        attributes: %{
          name: "newsletter",
          checked: false
        },
        slots: []
      },
      %Variation{
        id: :checkbox_default,
        attributes: %{
          name: "newsletter",
          label: "Deseja receber nossos emails?",
          checked: false
        },
        slots: []
      },
      %Variation{
        id: :checkbox_checked,
        attributes: %{
          name: "newsletter",
          label: "Deseja receber nossos emails?",
          checked: true
        },
        slots: []
      },
      %Variation{
        id: :checkbox_disabled,
        attributes: %{
          name: "newsletter",
          label: "Deseja receber nossos emails?",
          disabled: true
        },
        slots: []
      },
      %Variation{
        id: :checkbox_disabled_checked,
        attributes: %{
          name: "newsletter",
          label: "Deseja receber nossos emails?",
          disabled: true,
          checked: true
        },
        slots: []
      }
    ]
  end
end
