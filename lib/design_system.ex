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

  ### COMPONENTES DE INPUT ####

  @doc """
  Componente de checkbox, usado para representar valores que podem
  ter um valor ambíguo.

  O mesmo obrigatoriamente recebe o atributos `label`, que representa a etiqueta,
  o texto nome do campo em questão que é um checkbox.

  Também é possível controlar dinamicamente se o componente será desabilitado
  ou se o valor do checkbox será "assinado" com atributos `disabled` e
  `checked` respectivamente.

  ## Exemplo

      <.checkbox id="send-emails" label="Deseja receber nossos emails?" checked />
  """

  attr :id, :string, required: false
  attr :checked, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :label, :string, required: false, default: ""
  attr :field, Phoenix.HTML.FormField
  attr :name, :string
  attr :required, :boolean, default: false

  def checkbox(%{field: %Phoenix.HTML.FormField{}} = assigns) do
    assigns
    |> input()
    |> checkbox()
  end

  def checkbox(assigns) do
    ~H"""
    <div class="flex items-center checkbox-container">
      <input
        id={@name}
        name={@name}
        type="checkbox"
        checked={@checked}
        disabled={@disabled}
        value={@value}
        required={@required}
      />
      <label for={@name}>
        <.text size="base"><%= @label %></.text>
      </label>
    </div>
    """
  end

  @doc """
  Componente de radio, usado para representar valores que podem
  ter um valor ambíguo.

  O mesmo obrigatoriamente recebe o atributos `label`, que representa a etiqueta,
  o texto nome do campo em questão que é um radio.

  Também é possível controlar dinamicamente se o componente será desabilitado
  ou se o valor do radio será "assinado" com atributos `disabled` e
  `checked` respectivamente.

  ## Exemplo

      <.checkbox id="send-emails" label="Deseja receber nossos emails?" checked />
  """

  attr :id, :string, required: true
  attr :name, :string
  attr :disabled, :boolean, default: false
  attr :checked, :boolean, default: false
  attr :field, Phoenix.HTML.FormField

  slot :label, required: true

  def radio(%{field: %Phoenix.HTML.FormField{}} = assigns) do
    assigns
    |> input()
    |> radio()
  end

  def radio(assigns) do
    ~H"""
    <div class="radio-container">
      <input
        id={@id}
        name={@name}
        type="radio"
        disabled={@disabled}
        checked={@checked}
        class="radio-input"
      />
      <label for={@id} class="radio-label">
        <.text size="base"><%= render_slot(@label) %></.text>
      </label>
    </div>
    """
  end

  @doc """
  Um componente de input de texto, para receber entradas da pessoa
  usuária.

  O mesmo recebe obrigatoriamente os atributos `name` e `label`,
  para que seja possível o formulário que usar este componente
  direcionar corretamente o dado da entrada da pessoa usuária, e a
  etiqueta para ficar visivel sobre o que se trata o input em questão.

  Opcionalmente o componente também recebe o atributo `mask`, que controla
  o formato do texto que será escrito. Por exemplo um documento CPF tem o
  formato "111.111.111-11".

  Além disso é possível definir um texto de ajuda que será colocado "dentro"
  do componte, com o atributo `placeholder`.

  Caso queira dar um valor inicial para o componente, use o atributo `value`!

  ## Exemplo

      <.text_input name="cpf" mask="999.999.999-99" label="CPF" />

      <.text_input name="password" label="Senha" type="password" />
  """

  attr :id, :string, default: nil
  attr :type, :string, default: "text", values: ~w(date hidden cpf text password email phone)
  attr :placeholder, :string, required: false, default: ""
  attr :value, :string, required: false
  attr :mask, :string, required: false, default: nil
  attr :valid, :boolean, required: false, default: nil
  attr :label, :string, default: nil
  attr :field, Phoenix.HTML.FormField
  attr :name, :string

  attr :rest, :global, include: ~w(autocomplete disabled pattern placeholder readonly required)

  def text_input(%{field: %Phoenix.HTML.FormField{}} = assigns) do
    assigns
    |> input()
    |> text_input()
  end

  def text_input(assigns) do
    ~H"""
    <fieldset class="text-input-container">
      <label :if={@label} for={@name}>
        <.text size="lg"><%= @label %></.text>
      </label>
      <input
        id={@id}
        name={@name}
        value={@value}
        type={@type}
        placeholder={@placeholder}
        data-inputmask={if @mask, do: "mask: #{@mask}"}
        class={["input", text_input_state(@valid)]}
        {@rest}
      />
      <span :if={!is_nil(@valid)} class="dot">
        <Lucideicons.circle_check :if={@valid} />
        <Lucideicons.circle_x :if={!@valid} />
      </span>
    </fieldset>
    """
  end

  defp text_input_state(nil), do: "input-default"
  defp text_input_state(false), do: "input-error"
  defp text_input_state(true), do: "input-success"

  attr :id, :string, default: nil
  attr :name, :string, default: nil
  attr :disabled, :boolean, default: false
  attr :placeholder, :string, required: false, default: ""
  attr :value, :string, default: ""
  attr :valid, :boolean, required: false, default: nil
  attr :class, :string, default: ""

  slot :label, required: false

  def text_area(%{field: %Phoenix.HTML.FormField{}} = assigns) do
    assigns
    |> input()
    |> text_area()
  end

  def text_area(assigns) do
    ~H"""
    <fieldset class={@class}>
      <.text size="base"><%= render_slot(@label) %></.text>
      <div class="textarea-grow-wrapper">
        <textarea id={@id} name={@name} placeholder={@placeholder} disabled={@disabled} default=""><%= @value%></textarea>
      </div>
    </fieldset>
    """
  end

  # função interna para criação de inputs dinâmicos
  # cada componente de input possui sua função própria
  # para melhor semântica, como `text_input` ou `checkbox`
  defp input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:name, field.name)
    |> assign_new(:value, fn -> field.value end)
  end

  ### ACABA COMPONENTES DE INPUT ####

  @doc """
  Componente para criar links, que direcionam o usuário para outras
  páginas internas da aplicação ou páginas externas de outras aplicações.

  Recebe os mesmos atributos do componente nativo `Phoenix.Component.link/1`:

  - `navigate`: redireciona a pessoa usuária, sem recarregar a página
  - `patch`: redireciona a pessoa usuária para a mesma página, com parâmetros diferentes
  - `href`: redireciona a pessoa usuária para outra página, interna ou externa da aplicação,
  recarregando a página atual.

  Além desses atributos esse componente precisa de uma `label`, que será o texto
  exibido ao renderizar o link e também aceita um atributo opcional que controla
  o tamanho da fonte do texto renderizado. Os possíveis valores são os mesmos que
  o componente de texto definido em `PescarteWeb.DesignSystem.text/1`.

  ## Exemplo

      <.link navigate={~p"/app/perfil"}>Ir para Perfil</.link>

      <.link href="https://google.com" text_size="lg">Google.com</.link>

      <.link patch={~p"/app/relatorios"} text_size="lg">Recarregar lista de relatórios</.link>
  """

  attr :navigate, :string, required: false, default: nil
  attr :patch, :string, required: false, default: nil
  attr :href, :string, required: false, default: nil
  attr :method, :string, default: "get", values: ~w(get put post delete patch)
  attr :styless, :boolean, default: false
  attr :class, :string, default: ""

  slot :inner_block

  def link(assigns) do
    ~H"""
    <Phoenix.Component.link
      navigate={@navigate}
      patch={@patch}
      href={@href}
      method={@method}
      class={[if(!@styless, do: "link"), @class]}
    >
      <%= render_slot(@inner_block) %>
    </Phoenix.Component.link>
    """
  end

  @doc """
  Renders flash notices.
  ## Examples
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:info} phx-mounted={show("#flash")}>Welcome Back!</.flash>
  """
  attr :id, :string, default: "flash", doc: "the optional id of flash container"
  attr :flash, :map, default: %{}, doc: "the map of flash messages to display"
  attr :visible, :boolean, default: true

  attr :kind, :atom,
    values: [:success, :warning, :error],
    doc: "used for styling and flash lookup"

  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the flash container"

  slot :inner_block, doc: "the optional inner block that renders the flash message"

  def flash(assigns) do
    ~H"""
    <div
      :if={msg = render_slot(@inner_block) || Phoenix.Flash.get(@flash, @kind)}
      id={@id}
      phx-click={JS.push("lv:clear-flash", value: %{key: @kind}) |> hide("##{@id}")}
      role="alert"
      class={[
        "flash-component",
        Atom.to_string(@kind),
        if(@visible, do: "visible", else: "invisible")
      ]}
      {@rest}
    >
      <div class="flash">
        <Lucideicons.circle_check :if={@kind == :success} class="flash-icon" />
        <Lucideicons.info :if={@kind == :warning} class="flash-icon" />
        <Lucideicons.circle_x :if={@kind == :error} class="flash-icon" />
        <.text size="lg"><%= msg %></.text>
      </div>
    </div>
    """
  end

  @doc """
  Shows the flash group with standard titles and content.
  ## Examples
      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  def flash_group(assigns) do
    ~H"""
    <.flash kind={:success} flash={@flash} />
    <.flash kind={:warning} flash={@flash} />
    <.flash kind={:error} flash={@flash} />
    """
  end

  @doc """
  Renderiza um formulário simples.

  ## Exemplos

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
