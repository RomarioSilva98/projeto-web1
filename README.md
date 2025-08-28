<h1>🎵 Sistema de Gerenciamento de Bandas - SongFlow</h1>

<h2>📋 Descrição do Projeto</h2>
<p>Sistema completo para gerenciamento de repertórios musicais em bandas, com sincronização em tempo real durante apresentações. Desenvolvido como trabalho acadêmico para a disciplina Web I.</p>

<h2>🎯 Objetivo</h2>
<p>Gerenciar bandas, músicas, repertórios e membros com sincronização em tempo real durante shows, onde o responsável da banda controla a mudança de músicas para todos os integrantes simultaneamente.</p>

<h2>🛠️ Tecnologias Utilizadas</h2>

<h3>Backend</h3>
<ul>
  <li><b>Java Spring Boot</b> - Framework principal</li>
  <li><b>Spring Security</b> - Autenticação e autorização</li>
  <li><b>WebSocket</b> - Sincronização em tempo real</li>
  <li><b>MySQL</b> - Banco de dados relacional</li>
  <li><b>JPA/Hibernate</b> - ORM e persistência de dados</li>
  <li><b>Maven</b> - Gerenciamento de dependências</li>
</ul>

<h3>Frontend</h3>
<ul>
  <li><b>Flutter</b> - Framework multiplataforma</li>
  <li><b>Dart</b> - Linguagem de programação</li>
  <li><b>Syncfusion Flutter PDF Viewer</b> - Visualização de partituras</li>
  <li><b>WebSocket</b> - Comunicação em tempo real</li>
</ul>

<h2>📊 Funcionalidades</h2>

<h3>👤 Gestão de Usuários</h3>
<ul>
  <li>Cadastro e autenticação de músicos</li>
  <li>Perfil de usuário</li>
  <li>Participação em múltiplas bandas</li>
</ul>

<h3>🎸 Gestão de Bandas</h3>
<ul>
  <li>Criação e administração de bandas</li>
  <li>Adição/remoção de membros</li>
  <li>Um responsável principal por banda</li>
</ul>

<h3>🎶 Gestão de Músicas</h3>
<ul>
  <li>Cadastro de músicas em formato PDF</li>
  <li>Armazenamento de partituras e cifras</li>
  <li>Catálogo centralizado de músicas</li>
</ul>

<h3>📖 Gestão de Repertórios</h3>
<ul>
  <li>Criação de repertórios para shows</li>
  <li>Ordenação de músicas no repertório</li>
  <li>Adição/remoção não destrutiva de músicas</li>
</ul>

<h3>⚡ Sincronização em Tempo Real</h3>
<ul>
  <li>WebSocket para comunicação durante shows</li>
  <li>Controle centralizado pelo responsável da banda</li>
  <li>Mudança sincronizada de músicas em todos os dispositivos</li>
</ul>

<h2>🗃️ Estrutura do Banco de Dados</h2>
<p><b>Principais Entidades</b></p>
<ul>
  <li>Usuario - Músicos do sistema</li>
  <li>Banda - Grupos musicais</li>
  <li>Musica - Músicas do catálogo</li>
  <li>Repertorio - Listas de músicas para shows</li>
  <li>Participacao - Relação usuário-banda</li>
  <li>BandaMusica - Relação banda-música</li>
  <li>RepertorioMusicas - Relação repertório-música</li>
</ul>

<h2>🚀 Como Executar</h2>

<p><b>Pré-requisitos</b></p>
<ul>
  <li>Java JDK 17+</li>
  <li>Flutter SDK</li>
  <li>MySQL Server (ou outro banco, configure no application.properties)</li>
</ul>

<p><b>Backend (Spring Boot)</b></p>
<pre>cd back/projetowebI
mvn spring-boot:run</pre>

<p><b>Frontend (Flutter)</b></p>
<pre>cd front/projetoweb1
flutter pub get
flutter run</pre>

<h2>📱 Funcionalidades do App</h2>

<p><b>Telas Principais</b></p>
<ul>
  <li>Login/Registro - Autenticação de usuários</li>
  <li>Home - Dashboard principal</li>
  <li>Gerenciar Bandas - Criação e administração</li>
  <li>Criar Música - Upload de partituras PDF</li>
  <li>Gerenciar Repertório - Montagem de setlists</li>
  <li>Visualizador PDF - Exibição de partituras</li>
  <li>Show ao Vivo - Modo de apresentação sincronizado</li>
</ul>

<h2>🎨 Funcionalidades de Sincronização</h2>
<ul>
  <li>Início do Show - Responsável inicia sessão WebSocket</li>
  <li>Conexão dos Músicos - Integrantes conectam-se à sessão</li>
  <li>Controle de Músicas - Responsável avança músicas</li>
  <li>Sincronização Automática - Todos dispositivos atualizam simultaneamente</li>
</ul>

<h2>📊 Regras de Negócio</h2>
<ul>
  <li>Um usuário pode participar de múltiplas bandas</li>
  <li>Cada banda possui um único responsável</li>
  <li>Músicas removidas do repertório não são excluídas do sistema</li>
  <li>A ordem das músicas é sincronizada para todos os membros</li>
  <li>Apenas o responsável pode controlar a sequência durante shows</li>
</ul>

<p><b>PS:</b> Na pasta uploads tem os pdfs de musicas usados para testar e apresentar o projeto.</p>

<h2>💻 Desenvolvido por</h2>
<p>Romário</p>

<h2>📄 Licença</h2>
<p>Este projeto foi desenvolvido para fins acadêmicos como parte da avaliação da disciplina.</p>
