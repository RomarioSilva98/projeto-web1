<h1>🎵 Sistema de Gerenciamento de Bandas - SongFlow</h1>
<br>
<br>
📋 Descrição do Projeto

Sistema completo para gerenciamento de repertórios musicais em bandas, com sincronização em tempo real durante apresentações. Desenvolvido como trabalho acadêmico para a disciplina Web I.
<br>
<br>
🎯 Objetivo
<br>
Gerenciar bandas, músicas, repertórios e membros com sincronização em tempo real durante shows, onde o responsável da banda controla a mudança de músicas para todos os integrantes simultaneamente.
<br>
<br>
🛠️ Tecnologias Utilizadas
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
Frontend
<br>
<br>
Flutter - Framework multiplataforma

Dart - Linguagem de programação

Syncfusion Flutter PDF Viewer - Visualização de partituras

WebSocket - Comunicação em tempo real
<br>
<br>
📊 Funcionalidades
<br>
<br>
👤 Gestão de Usuários

Cadastro e autenticação de músicos

Perfil de usuário

Participação em múltiplas bandas
<br>
<br>
🎸 Gestão de Bandas

Criação e administração de bandas

Adição/remoção de membros

Um responsável principal por banda
<br>
<br>
🎶 Gestão de Músicas

Cadastro de músicas em formato PDF

Armazenamento de partituras e cifras

Catálogo centralizado de músicas
<br>
<br>
📖 Gestão de Repertórios

Criação de repertórios para shows

Ordenação de músicas no repertório

Adição/remoção não destrutiva de músicas
<br>
<br>
⚡ Sincronização em Tempo Real

WebSocket para comunicação durante shows

Controle centralizado pelo responsável da banda

Mudança sincronizada de músicas em todos os dispositivos
<br>
<br>
🗃️ Estrutura do Banco de Dados

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
🚀 Como Executar:
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


📱 Funcionalidades do App


Telas Principais

Login/Registro - Autenticação de usuários

Home - Dashboard principal

Gerenciar Bandas - Criação e administração

Criar Música - Upload de partituras PDF

Gerenciar Repertório - Montagem de setlists

Visualizador PDF - Exibição de partituras

Show ao Vivo - Modo de apresentação sincronizado



🎨 Funcionalidades de Sincronização

Início do Show - Responsável inicia sessão WebSocket

Conexão dos Músicos - Integrantes conectam-se à sessão

Controle de Músicas - Responsável avança músicas

Sincronização Automática - Todos dispositivos atualizam simultaneamente



📊 Regras de Negócio

Um usuário pode participar de múltiplas bandas

Cada banda possui um único responsável

Músicas removidas do repertório não são excluídas do sistema

A ordem das músicas é sincronizada para todos os membros

Apenas o responsável pode controlar a sequência durante shows



PS: Na pasta uploads tem os pdfs de musicas usados para testar e apresentar o projeto.
<br>
<br>

👥 Desenvolvido por

Romário
<br>

📄 Licença
<br>

Este projeto foi desenvolvido para fins acadêmicos como parte da avaliação da disciplina.
