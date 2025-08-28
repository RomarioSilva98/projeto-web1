🎵 Sistema de Gerenciamento de Bandas - SongFlow



📋 Descrição do Projeto

Sistema completo para gerenciamento de repertórios musicais em bandas, com sincronização em tempo real durante apresentações. Desenvolvido como trabalho acadêmico para a disciplina Web I.


🎯 Objetivo

Gerenciar bandas, músicas, repertórios e membros com sincronização em tempo real durante shows, onde o responsável da banda controla a mudança de músicas para todos os integrantes simultaneamente.


🛠️ Tecnologias Utilizadas

Backend

Java Spring Boot - Framework principal

Spring Security - Autenticação e autorização

WebSocket - Sincronização em tempo real

MySQL - Banco de dados relacional

JPA/Hibernate - ORM e persistência de dados

Maven - Gerenciamento de dependências



Frontend

Flutter - Framework multiplataforma

Dart - Linguagem de programação

Syncfusion Flutter PDF Viewer - Visualização de partituras

WebSocket - Comunicação em tempo real



📊 Funcionalidades


👤 Gestão de Usuários

Cadastro e autenticação de músicos

Perfil de usuário

Participação em múltiplas bandas


🎸 Gestão de Bandas

Criação e administração de bandas

Adição/remoção de membros

Um responsável principal por banda


🎶 Gestão de Músicas

Cadastro de músicas em formato PDF

Armazenamento de partituras e cifras

Catálogo centralizado de músicas


📖 Gestão de Repertórios

Criação de repertórios para shows

Ordenação de músicas no repertório

Adição/remoção não destrutiva de músicas


⚡ Sincronização em Tempo Real

WebSocket para comunicação durante shows

Controle centralizado pelo responsável da banda

Mudança sincronizada de músicas em todos os dispositivos


🗃️ Estrutura do Banco de Dados

Principais Entidades

Usuario - Músicos do sistema

Banda - Grupos musicais

Musica - Músicas do catálogo

Repertorio - Listas de músicas para shows

Participacao - Relação usuário-banda

BandaMusica - Relação banda-música

RepertorioMusicas - Relação repertório-música



🚀 Como Executar


Pré-requisitos

Java JDK 17+

Flutter SDK

MySQL Server (ou outro banco, configure no application.properties)



Backend (Spring Boot)

cd back/projetowebI

mvn spring-boot:run


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


👥 Desenvolvido por

Romário/n

📄 Licença

Este projeto foi desenvolvido para fins acadêmicos como parte da avaliação da disciplina.
