defmodule Storybook.Welcome do
  use PhoenixStorybook.Story, :page

  # Conteúdo introdutório para a página de boas-vindas
  def introduction(assigns) do
    ~H"""
    <div class="text-lg mb-4">
      <h1 class="font-bold text-blue-100">Boas vindas ao Storybook do PEA Pescarte</h1>
      <p>O PEA Pescarte é uma iniciativa inovadora que busca integrar pescadores artesanais e suas famílias através de uma rede social regional, fomentando a sustentabilidade ambiental e fortalecendo as comunidades pesqueiras.</p>
    </div>
    """
  end

  # Seção de objetivos do projeto
  def objectives(assigns) do
    ~H"""
    <div class="mb-6">
      <h2 class="font-bold text-blue-80">Objetivos</h2>
      <ul class="list-disc pl-5 text-black-80">
        <li>Promover a educação ambiental entre as comunidades pesqueiras.</li>
        <li>Auxiliar na organização comunitária e no desenvolvimento de redes de apoio mútuo.</li>
        <li>Oferecer treinamentos para aperfeiçoamento das habilidades profissionais dos envolvidos.</li>
        <li>Incentivar a participação em projetos de geração de trabalho e renda de maneira sustentável.</li>
      </ul>
    </div>
    """
  end

  # Seção de metodologia do projeto
  def methodology(assigns) do
    ~H"""
    <div class="mb-6">
      <h2 class="font-bold text-green-100">Metodologia</h2>
      <p>Adotamos uma abordagem participativa e inclusiva, com workshops, projetos comunitários e suporte contínuo para assegurar a eficácia e sustentabilidade das iniciativas.</p>
    </div>
    """
  end

  # Seção de resultados esperados
  def expected_results(assigns) do
    ~H"""
    <div>
      <h2 class="font-bold text-orange-100">Resultados Esperados</h2>
      <p>Esperamos fortalecer a economia local, melhorar a gestão de recursos naturais e aumentar a conscientização sobre a preservação ambiental.</p>
    </div>
    """
  end

  # Renderiza a página de boas-vindas
  def render(assigns) do
    ~H"""
    <div class="container">
      <.introduction />
      <.objectives />
      <.methodology />
      <.expected_results />
    </div>
    """
  end
end
