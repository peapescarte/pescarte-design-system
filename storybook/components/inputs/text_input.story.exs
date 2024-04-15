defmodule Storybook.Components.Inputs.TextInput do
  use PhoenixStorybook.Story, :component
  alias DesignSystem

  def function, do: &DesignSystem.text_input/1
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
        id: :text_input_default,
        attributes: %{
          name: "user_name",
          label: "Nome do Usuário",
          placeholder: "Digite seu nome",
          type: "text"
        },
        slots: []
      },
      %Variation{
        id: :text_input_with_mask,
        attributes: %{
          name: "cpf",
          label: "CPF",
          mask: "999.999.999-99",
          placeholder: "000.000.000-00"
        },
        slots: []
      },
      %Variation{
        id: :text_input_password,
        attributes: %{
          name: "password",
          label: "Senha",
          type: "password",
          placeholder: "Digite sua senha"
        },
        slots: []
      }
    ]
  end
end
