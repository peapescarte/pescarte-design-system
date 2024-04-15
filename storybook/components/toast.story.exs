defmodule Storybook.Components.Toast do
  use PhoenixStorybook.Story, :component

  def function, do: &DesignSystem.flash/1
  def imports, do: [{DesignSystem, [button: 1, show: 1]}]
  def aliases, do: [Phoenix.LiveView.JS]

  def template do
    """
    <.button style="primary" click={JS.remove_class("invisible", to: "#:variation_id")} psb-code-hidden>
      Open Toast
    </.button>
    <.psb-variation/>
    """
  end

  def variations do
    [
      %Variation{
        id: :success,
        attributes: %{
          visible: false,
          kind: :success
        },
        slots: [~s|Operação realizada com sucesso!|]
      },
      %Variation{
        id: :warning,
        attributes: %{
          visible: false,
          kind: :warning
        },
        slots: [~s|Atenção! Verifique os campos.|]
      },
      %Variation{
        id: :error,
        attributes: %{
          visible: false,
          kind: :error
        },
        slots: [~s|Erro ao processar a solicitação.|]
      }
    ]
  end
end
