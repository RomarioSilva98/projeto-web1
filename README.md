<h1>🎵 Sistema de Gerenciamento de Bandas - SongFlow</h1>
<br>
<br>
<h2>📋 Descrição do Projeto</h2>

Sistema completo para gerenciamento de repertórios musicais em bandas, com sincronização em tempo real durante apresentações. Desenvolvido como trabalho acadêmico para a disciplina Web I.
<br>
<br>
<h2>🎯 Objetivo</h2>
<br>
Gerenciar bandas, músicas, repertórios e membros com sincronização em tempo real durante shows, onde o responsável da banda controla a mudança de músicas para todos os integrantes simultaneamente.
<br>
<br>
<h2>🛠️ Tecnologias Utilizadas</h2>
<br>
<br>
Backend

Java Spring Boot - Framework principal

Spring Security - Autenticação e autorização

WebSocket - Sincronização em tempo real

MySQL - Banco de dados relacional

JPA/Hibernate - ORM e persistência de dados

Maven - Gerenciamento de dependências
<br>
<br>
<br>
<b>Frontend</b>

Flutter - Framework multiplataforma

Dart - Linguagem de programação

Syncfusion Flutter PDF Viewer - Visualização de partituras

WebSocket - Comunicação em tempo real

<h2>📊 Funcionalidades </h2>

<h3>👤 Gestão de Usuários </h3>


Cadastro e autenticação de músicos

Perfil de usuário

Participação em múltiplas bandas
<br>
<br>
<h2>🎸 Gestão de Bandas </h2>


Criação e administração de bandas

Adição/remoção de membros

Um responsável principal por banda
<br>
<br>
<h2🎶 Gestão de Músicas> </h2>


Cadastro de músicas em formato PDF

Armazenamento de partituras e cifras

Catálogo centralizado de músicas
<br>
<br>
<h2>📖 Gestão de Repertórios </h2>


Criação de repertórios para shows

Ordenação de músicas no repertório

Adição/remoção não destrutiva de músicas
<br>
<br>
<h2>⚡ Sincronização em Tempo Real </h2>


WebSocket para comunicação durante shows

Controle centralizado pelo responsável da banda

Mudança sincronizada de músicas em todos os dispositivos
<br>
<br>
<h2>🗃️ Estrutura do Banco de Dados </h2>


Principais Entidades

Usuario - Músicos do sistema

Banda - Grupos musicais

Musica - Músicas do catálogo

Repertorio - Listas de músicas para shows

Participacao - Relação usuário-banda

BandaMusica - Relação banda-música

RepertorioMusicas - Relação repertório-música
<br>
<br>
<h2>🚀 Como Executar:</h2>

<br>
<br>
Pré-requisitos

Java JDK 17+

Flutter SDK

MySQL Server (ou outro banco, configure no application.properties)
<br>
<br>
Backend (Spring Boot)

cd back/projetowebI

mvn spring-boot:run
<br>
<br>
Frontend (Flutter)

cd front/projetoweb1

flutter pub get

flutter run

<h2>📱 Funcionalidades do App</h2>



Telas Principais

Login/Registro - Autenticação de usuários

Home - Dashboard principal

Gerenciar Bandas - Criação e administração

Criar Música - Upload de partituras PDF

Gerenciar Repertório - Montagem de setlists

Visualizador PDF - Exibição de partituras

Show ao Vivo - Modo de apresentação sincronizado


<h2>🎨 Funcionalidades de Sincronização </h2>


Início do Show - Responsável inicia sessão WebSocket

Conexão dos Músicos - Integrantes conectam-se à sessão

Controle de Músicas - Responsável avança músicas

Sincronização Automática - Todos dispositivos atualizam simultaneamente


<h2>📊 Regras de Negócio </h2>


Um usuário pode participar de múltiplas bandas

Cada banda possui um único responsável

Músicas removidas do repertório não são excluídas do sistema

A ordem das músicas é sincronizada para todos os membros

Apenas o responsável pode controlar a sequência durante shows



PS: Na pasta uploads tem os pdfs de musicas usados para testar e apresentar o projeto.
<br>
<br>
<h2>👥 Desenvolvido por</h2>


Romário
<br>

📄 Licença
<br>

Este projeto foi desenvolvido para fins acadêmicos como parte da avaliação da disciplina.
