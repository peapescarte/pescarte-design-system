defmodule DesignSystem do
  use Phoenix.Component

  import PhoenixHTMLHelpers.Tag, only: [content_tag: 3]

  alias Phoenix.LiveView.JS

  @text_sizes ~w(h1 h2 h3 h4 h5 base lg sm)

  @doc """
  Este componente renderiza um texto, porém com os estilos
  do espaçamento de linha e tamanho de fonte já pré-configurados.

  Também recebe um atributo chamado `color`, que é uma classe do TailwindCSS
  que representa uma cor específica da paleta que o Design System define.

  Caso o atributo `color` não seja fornecido, a cor padrão - `black-80` -
  será utilizada.

  Para ver as cores disponívels, execute o comando `mix tailwind.view`.

  Você pode prover classes adicionais para estilização, com o atributo
  opcional `class`, que recebe uma string.

  ## Exemplo

      <.text size="h1"> Lorem ipsum dolor sit amet </.text>
  """

  attr :size, :string, values: @text_sizes, required: true
  attr :color, :string, default: "text-black-80"
  attr :class, :string, required: false, default: ""

  slot :inner_block

  def text(%{size: "h" <> _} = assigns) do
    ~H"""
    <%= content_tag @size, class: get_text_style(@size, @color, @class) do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  def text(assigns) do
    ~H"""
    <p class={get_text_style(@size, @color, @class)}>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  defp get_text_style("h1", color, custom_class),
    do: get_text_style("text-4xl leading-10 font-bold" <> " " <> color, custom_class)

  defp get_text_style("h2", color, custom_class),
    do: get_text_style("text-3xl leading-8 font-bold" <> " " <> color, custom_class)

  defp get_text_style("h3", color, custom_class),
    do: get_text_style("text-2xl leading-7 font-bold" <> " " <> color, custom_class)

  defp get_text_style("h4", color, custom_class),
    do: get_text_style("text-xl leading-6 font-medium" <> " " <> color, custom_class)

  defp get_text_style("h5", color, custom_class),
    do: get_text_style("text-lg leading-3 font-medium" <> " " <> color, custom_class)

  defp get_text_style("base", color, custom_class),
    do: get_text_style("text-base leading-4 font-medium" <> " " <> color, custom_class)

  defp get_text_style("lg", color, custom_class),
    do: get_text_style("text-lg leading-5 font-regular" <> " " <> color, custom_class)

  defp get_text_style("sm", color, custom_class),
    do: get_text_style("text-sm leading-3 font-regular" <> " " <> color, custom_class)

  defp get_text_style(final_class, custom_class) do
    final_class <> " " <> custom_class
  end

  @doc """
  Componente de botão, que representa uma ação na plataforma.

  Esse componente possui 2 variantes:

  - Primário
  - Secundário

  que é controlado pelo atributo `style`.

  Esse componente també pode ter um ícone em conjunto com o texto,
  basta informar o nome do ícone da biblioteca [lucide](https://lucide.dev),
  em minúsculo (veja o exemplo abaixo).

  Caso o componente esteja dentro de um formulário, passe o atributo `submit`,
  desta forma o botão irá ser acionado assim que o formua'ário tiver seu
  preenchimento finalizado.

  ## Exemplo

      <.button style="primary"> Primário </.button>

      <.button style="secondary"> Secundário </.button>

      <.button style="primary" submit> Submissão </.button>
  """

  attr :name, :string, default: ""
  attr :value, :string, default: ""
  attr :style, :string, values: ~w(primary secondary link), required: true
  attr :submit, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :class, :string, default: ""
  attr :click, :string, default: "", doc: ~s(the click event to handle)
  attr :rest, :global, doc: ~s(used for phoenix events like "phx-target")

  slot :inner_block

  def button(assigns) do
    ~H"""
    <button
      name={@name}
      value={@value}
      type={if @submit, do: "submit", else: "button"}
      class={["btn", "btn-#{@style}", @class]}
      phx-click={@click}
      disabled={@disabled}
      {@rest}
    >
      <.text :if={@style == "primary"} size="base" color="text-white-100">
        <%= render_slot(@inner_block) %>
      </.text>

      <.text :if={@style != "primary"} size="base" color="text-blue-80">
        <%= render_slot(@inner_block) %>
      </.text>
    </button>
    """
  end

  @doc """
  Renders a simple form.

  ## Examples

      <.simple_form for={@form} phx-change="validate" phx-submit="save">
        <.input field={@form[:email]} label="Email"/>
        <.input field={@form[:username]} label="Username" />
        <:actions>
          <.button>Save</.button>
        </:actions>
      </.simple_form>
  """
  attr :for, :any, required: true, doc: "the datastructure for the form"
  attr :as, :any, default: nil, doc: "the server side parameter to collect all input under"

  attr :rest, :global,
    include: ~w(autocomplete name rel action enctype method novalidate target multipart),
    doc: "the arbitrary HTML attributes to apply to the form tag"

  slot :inner_block, required: true
  slot :actions, doc: "the slot for form actions, such as a submit button"

  def simple_form(assigns) do
    ~H"""
    <.form :let={f} for={@for} as={@as} {@rest}>
      <div class="mt-10 space-y-8 bg-white">
        <%= render_slot(@inner_block, f) %>
        <div :for={action <- @actions} class="mt-2 flex items-center justify-between gap-6">
          <%= render_slot(action, f) %>
        </div>
      </div>
    </.form>
    """
  end

  ## JS Commands

  def show(js \\ %JS{}, selector) do
    JS.show(js,
      to: selector,
      transition:
        {"transition-all transform ease-out duration-300",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
         "opacity-100 translate-y-0 sm:scale-100"}
    )
  end

  def hide(js \\ %JS{}, selector) do
    JS.hide(js,
      to: selector,
      time: 200,
      transition:
        {"transition-all transform ease-in duration-200",
         "opacity-100 translate-y-0 sm:scale-100",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"}
    )
  end
end
